//
//  VideoOptionsTableViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 29/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "VideoOptionsTableViewController.h"

@interface VideoOptionsTableViewController ()

@end

@implementation VideoOptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.player.numberOfAudioTracks;
            break;
        case 1:
            return self.player.numberOfSubtitlesTracks;
            break;
    }
    
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Audio track";
            break;
        case 1:
            return @"Subtitles track";
        default:
            break;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.player.audioTrackNames[indexPath.row];
            cell.accessoryType = self.player.currentAudioTrackIndex == indexPath.row ?
            UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            break;
        case 1:
            cell.textLabel.text = self.player.videoSubTitlesNames[indexPath.row];
            cell.accessoryType = self.player.currentVideoSubTitleIndex == indexPath.row ?
            UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row != self.player.currentAudioTrackIndex) {
            self.player.currentAudioTrackIndex = (int)indexPath.row;
            [self.tableView reloadData];
        }
    }
    
    // TODO: subtitle selection not working properly - fix this.
    if (indexPath.section == 1) {
        if (indexPath.row != self.player.currentVideoSubTitleIndex) {
            self.player.currentVideoSubTitleIndex = (int)indexPath.row;
            [self.tableView reloadData];
        }
    }
}

@end
