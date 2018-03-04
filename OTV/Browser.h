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

- (void)browseToItem:(OTVItem *)item
withCompletionHandler:(void (^)(NSArray <OTVItem *> *items, NSError *error))completionHandler;

@end
