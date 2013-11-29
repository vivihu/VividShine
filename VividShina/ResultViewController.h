//
//  ResultViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ResultViewController : RootViewController
{
    IBOutlet UILabel *One;
    IBOutlet UILabel *two;
    IBOutlet UILabel *three;
    IBOutlet UILabel *four;
}

- (IBAction)nextStep:(id)sender;

- (void)configResult:(NSMutableArray *)seletedBalls;

@end
