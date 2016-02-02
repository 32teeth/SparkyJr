//
//  sparkyViewController.h
//  SparkyJr
//
//  Created by eugene andruszczenko on 2014-04-07.
//  Copyright (c) 2014 eugene andruszczenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sparkyViewController : UIViewController
/**
 *  labels
 **/
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

/**
 *  timer
 **/
@property (strong, nonatomic) NSTimer* timer;

@end
