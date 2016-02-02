//
//  sparkyViewController.m
//  SparkyJr
//
//  Created by eugene andruszczenko on 2014-04-07.
//  Copyright (c) 2014 eugene andruszczenko. All rights reserved.
//

#import "sparkyViewController.h"

@interface sparkyViewController ()

@end

@implementation sparkyViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.loadingLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    self.loadingLabel.text = @"loading";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(introViewSegue:) userInfo:nil repeats:NO];
}

-(void)introViewSegue:(NSTimer *)timer
{
    [self performSegueWithIdentifier:@"sparkyIntroSegue" sender:self];
}

@end
