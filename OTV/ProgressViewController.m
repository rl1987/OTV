//
//  ProgressViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 10/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "ProgressViewController.h"

#import "Browser.h"
#import "VideoViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface ProgressViewController ()

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSURL *fileURL;

@end

@implementation ProgressViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.task =
    [[Browser sharedInstance]
     downloadItem:self.item
     withProgress:^(double percentageDownloaded) {
         self.progressView.progress = (float)percentageDownloaded;
    } andCompletionHandler:^(NSURL *fileURL, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:nil];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        self.fileURL = fileURL;
        [self performSegueWithIdentifier:@"show_file" sender:nil];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    VideoViewController *vvc = (VideoViewController *)segue.destinationViewController;
    
    vvc.videoURL = self.fileURL;
}

@end
