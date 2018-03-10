//
//  Browser.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "Browser.h"

#import <AFNetworking/AFNetworking.h>
#import <hpple/TFHpple.h>

@interface Browser()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSURL *currentURL;

@end

@implementation Browser

+ (instancetype)sharedInstance
{
    static Browser *_sharedInstance = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFCompoundResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
 
    return self;
}

- (void)browseToItem:(OTVItem *)item
withCompletionHandler:(void (^)(NSArray <OTVItem *> *items, NSError *error))completionHandler {
    if (!item) {
        item = [[OTVItem alloc] init];
        item.isDirectory = YES;
        item.url = [NSURL URLWithString:@"http://omarroms.homeip.net"];
    }
    
    if (item.isDirectory == NO)
        completionHandler(nil, [[NSError alloc] init]);
    
    [self.manager GET:[item.url absoluteString]
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            printf(".");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.currentURL = item.url;
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        if (item.name) {
            OTVItem *backItem = [[OTVItem alloc] init];
            backItem.name = @"..";
            backItem.isDirectory = YES;
            backItem.url = [self.currentURL URLByAppendingPathComponent:@".."];
            
            [items addObject:backItem];
        }
        
        NSData *htmlData = (NSData *)responseObject;
        
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:htmlData];
        NSArray<TFHppleElement *> *elements = [hpple searchWithXPathQuery:@"//div[@class='fileInfo']//a"];
        
        for (TFHppleElement *e in elements) {
            OTVItem *newItem = [[OTVItem alloc] init];
            
            newItem.name = [e.attributes[@"href"] stringByRemovingPercentEncoding];
            newItem.url = [item.url URLByAppendingPathComponent:newItem.name];
            newItem.isDirectory = [newItem.name hasSuffix:@"/"];
            
            [items addObject:newItem];
        }
        
        completionHandler(items, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

- (void)getSizeOfItem:(OTVItem *)item
withCompletionHandler:(void (^)(long long size, NSError *error))completionHandler {
    [self.manager HEAD:[item.url absoluteString] parameters:nil
               success:^(NSURLSessionDataTask * _Nonnull task) {
                   completionHandler(task.response.expectedContentLength, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(0, error);
    }];
}

- (NSURLSessionDownloadTask *)downloadItem:(OTVItem *)item
                          withProgress:(void (^)(double percentageDownloaded))progressBlock
                  andCompletionHandler:(void (^)(NSURL *fileURL, NSError *error))completionHandler{
    NSURLSessionDownloadTask *task =
    [self.manager downloadTaskWithRequest:[NSURLRequest requestWithURL:item.url]
                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                     double percentage = (double)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                                     
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         progressBlock(percentage);
                                     });
                                     
                                 } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                     NSURL *cachesDirectoryURL =
                                     [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
                                                                            inDomain:NSUserDomainMask
                                                                   appropriateForURL:nil
                                                                              create:YES
                                                                               error:nil];
                                     
                                     return [cachesDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                 } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         completionHandler(filePath, error);
                                     });
                                 }];
    
    [task resume];
    
    return task;
}

@end
