//
//  HomeViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RootViewController.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *_kvScrollView;
    IBOutlet UIPageControl *_pageControl;
    
    IBOutlet UIButton *_btn1;
    IBOutlet UIButton *_btn2;
    IBOutlet UIButton *_btn3;
    NSTimer *_timer;
}

- (IBAction)testingStyle:(id)sender;
- (IBAction)lipstickSeries:(id)sender;
- (IBAction)limitedGift:(id)sender;

@end
