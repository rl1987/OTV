//
//  VideoOptionsTableViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 29/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "VideoOptionsTableViewController.h"

@implementation VideoOptionsTableViewController

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
            
            NSUInteger subIndex = [self.player.videoSubTitlesIndexes[indexPath.row] intValue];
            
            cell.accessoryType = subIndex == self.player.currentVideoSubTitleIndex ?
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
    
    if (indexPath.section == 1) {
        int subIndex = [self.player.videoSubTitlesIndexes[indexPath.row] intValue];
        
        if (subIndex != self.player.currentVideoSubTitleIndex) {
            self.player.currentVideoSubTitleIndex = (int)subIndex;
            [self.tableView reloadData];
        }
    }
}

@end
