//
//  BallViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface BallViewController : RootViewController
{
    IBOutlet UILabel *optionalBall;
    NSMutableArray *_selectedBalls;
    int balls;
}

- (IBAction)selectType:(id)sender;

@end
