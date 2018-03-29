//
//  VideoOptionsTableViewController.h
//  OTV
//
//  Created by Rimantas Lukosevicius on 29/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TVVLCKit/TVVLCKit.h>

@interface VideoOptionsTableViewController : UITableViewController

@property (nonatomic, weak) VLCMediaPlayer *player;

@end
