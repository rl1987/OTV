//
//  VideoViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "VideoViewController.h"

#import <TVVLCKit/TVVLCKit.h>

@interface VideoViewController ()

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (nonatomic, strong) VLCMediaPlayer *player;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.player = [[VLCMediaPlayer alloc] init];
    self.player.drawable = self.videoView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    VLCMedia *media = [VLCMedia mediaWithURL:self.videoURL];
    
    self.player.media = media;
    
    [self.player play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    
    [super viewWillDisappear:animated];
}

#pragma - IBActions

- (IBAction)pauseTapped:(id)sender {
    if (self.player.isPlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
}

- (IBAction)swipeRight:(id)sender {
    [self.player shortJumpForward];
}

- (IBAction)swipeLeft:(id)sender {
    [self.player shortJumpBackward];
}

- (IBAction)menuTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
