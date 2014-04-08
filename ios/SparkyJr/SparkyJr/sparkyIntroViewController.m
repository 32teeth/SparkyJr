//
//  sparkyIntroViewController.m
//  SparkyJr
//
//  Created by eugene andruszczenko on 2014-04-07.
//  Copyright (c) 2014 eugene andruszczenko. All rights reserved.
//

#import "sparkyIntroViewController.h"

@interface sparkyIntroViewController ()

@end

@implementation sparkyIntroViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.y = -101;
    self.titleLabel.frame = titleFrame;
    self.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:36.0f];
    self.titleLabel.text = @"SparkyJr.";

    self.subtitleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:10.0f];
    self.subtitleLabel.text = @"RGB LED Controller";
    self.subtitleLabel.alpha = 0;
    
    CGRect stickFrame = self.stickImageView.frame;
    stickFrame.origin.y = self.view.frame.size.height;
    self.stickImageView.frame = stickFrame;
    
    CGRect rainbowFrame = self.rainbowImageView.frame;
    rainbowFrame.origin.y = self.view.frame.size.height + 41;
    self.rainbowImageView.frame = rainbowFrame;
}

- (void)viewDidAppear:(BOOL)animated
{
    CGRect stickFrame = self.stickImageView.frame;
    CGRect rainbowFrame = self.rainbowImageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    stickFrame.origin.y = 294;
    rainbowFrame.origin.y = 335;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationBeginsFromCurrentState:YES];

    self.stickImageView.frame = stickFrame;
    self.rainbowImageView.frame = rainbowFrame;
    
    [UIView commitAnimations];

    titleFrame.origin.y = 204;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.75];
    
    self.titleLabel.frame = titleFrame;
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:1.25];
    
    self.subtitleLabel.alpha = 1;
    self.rainbowImageView.alpha = 0;     
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
