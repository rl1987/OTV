//
//  OTVItem.h
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTVItem : NSObject

@property (nonatomic, assign) BOOL isDirectory;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *url;

@end
