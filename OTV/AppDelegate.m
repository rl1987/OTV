//
//  AppDelegate.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "AppDelegate.h"

#import "Browser.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Browser *browser = [[Browser alloc] init];
    
    [browser browseToItem:nil withCompletionHandler:^(NSArray<OTVItem *> *items, NSError *error) {
        NSLog(@"%@", items);
        
        [browser browseToItem:[items firstObject]
        withCompletionHandler:^(NSArray<OTVItem *> *items, NSError *error) {
            NSLog(@"%@", items);
        }];
    }];
    
    return YES;
}

@end
