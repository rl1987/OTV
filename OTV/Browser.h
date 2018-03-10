//
//  Browser.h
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OTVItem.h"

@interface Browser : NSObject

+ (instancetype)sharedInstance;

- (void)browseToItem:(OTVItem *)item
withCompletionHandler:(void (^)(NSArray <OTVItem *> *items, NSError *error))completionHandler;

- (void)getSizeOfItem:(OTVItem *)item
withCompletionHandler:(void (^)(long long size, NSError *error))completionHandler;

- (NSURLSessionDownloadTask *)downloadItem:(OTVItem *)item
                          withProgress:(void (^)(double percentageDownloaded))progressBlock
                  andCompletionHandler:(void (^)(NSURL *fileURL, NSError *error))completionHandler;

@end
