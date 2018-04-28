//
//  ChoiceViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 10/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "ChoiceViewController.h"

#import "Browser.h"
#import "VideoViewController.h"
#import "ProgressViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <FormatterKit/TTTUnitOfInformationFormatter.h>

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    TTTUnitOfInformationFormatter *formatter = [[TTTUnitOfInformationFormatter alloc] init];
    
    [[Browser sharedInstance] getSizeOfItem:self.item
                      withCompletionHandler:^(long long size, NSError *error) {
                          if (error) {
                              [SVProgressHUD showErrorWithStatus:nil];
                              return;
                          }
                          
                          NSString *sizeString =
                          [formatter stringFromNumber:@(size) ofUnit:TTTByte];
                          
                          UIAlertController *alertControler =
                          [UIAlertController alertControllerWithTitle:self.item.name
                                                              message:sizeString
                                                       preferredStyle:UIAlertControllerStyleAlert];
                          
                          UIAlertAction *streamAction =
                          [UIAlertAction actionWithTitle:@"Stream"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     [self performSegueWithIdentifier:@"stream" sender:self.item];
                          }];
                          [alertControler addAction:streamAction];
                          
                          UIAlertAction *downloadAction =
                          [UIAlertAction actionWithTitle:@"Download"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     [self performSegueWithIdentifier:@"download" sender:self.item];
                          }];
                          [alertControler addAction:downloadAction];
                          
                          UIAlertAction *cancelAction =
                          [UIAlertAction actionWithTitle:nil
                                                   style:UIAlertActionStyleCancel
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                 }];
                          
                          [alertControler addAction:cancelAction];

                          [self presentViewController:alertControler
                                             animated:YES
                                           completion:NULL];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"download"]) {
        ProgressViewController *pvc = (ProgressViewController *)segue.destinationViewController;
        
        pvc.item = self.item;
    } else if ([segue.identifier isEqualToString:@"stream"]) {
        VideoViewController *vvc = (VideoViewController *)segue.destinationViewController;
        
        vvc.videoURL = self.item.url;
    }
}

@end
