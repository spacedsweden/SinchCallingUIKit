//
//  SINUIKitViewController.m
//  SinchCallingUIKit
//
//  Created by d on 06/22/2015.
//  Copyright (c) 2014 d. All rights reserved.
//

#import "SINUIKitViewController.h"
#import <SinchCallingUIKit/SinchCallingUIKit.h>
@interface SINUIKitViewController ()

@end

@implementation SINUIKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)call:(id)sender {
    [[CallingManager sharedManager] callNumber:@"+15612600684"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
