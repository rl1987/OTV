//
//  AcknowledgementsViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 05/06/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "AcknowledgementsViewController.h"

@interface AcknowledgementsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AcknowledgementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =
    [[NSBundle mainBundle] pathForResource:@"Pods-OTV-acknowledgements"
                                    ofType:@"markdown"];
    
    assert(path);
    
    self.textView.text = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL];
    
    self.textView.userInteractionEnabled = YES;
    self.textView.selectable = YES;
    self.textView.scrollEnabled = YES;
    self.textView.panGestureRecognizer.allowedTouchTypes = @[ @(UITouchTypeIndirect) ];
}

@end
