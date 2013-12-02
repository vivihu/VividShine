//
//  LipstickViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "LipstickViewController.h"
#import "LeftViewController.h"
#import "MidViewController.h"
#import "RightViewController.h"

@interface LipstickViewController ()
{
    UIView *_slider;
}

@end

@implementation LipstickViewController

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
    [self customTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom method
- (void)customTabBar {
//  三个viewController
    [self creatViewControllers];
//  隐藏系统tabbar
    [self hideTabBar];
//  创建自定义tabbar
    [self creatTabBar];
}

- (void)creatViewControllers
{
    LeftViewController *leftVC = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    MidViewController *midVC = [[MidViewController alloc] initWithNibName:@"MidViewController" bundle:nil];
    RightViewController *rightVC = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    self.viewControllers = @[leftVC,midVC,rightVC];
}

- (void)hideTabBar
{
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,
                                   contentView.bounds.origin.y,
                                   contentView.bounds.size.width,
                                   contentView.bounds.size.height + self.tabBar.frame.size.height);
    self.tabBar.hidden = YES;
}

- (void)creatTabBar
{
    NSArray *labelText = @[ @"凝于唇  花漾  “琉光主角唇膏”",
                            @"恋于眸   花漾恋波眼影",
                            @"跃于指  花漾指甲油"
                            ];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(1+i*340, 84, 340, 44)];
        [btn setTag:i+100];
        [btn addTarget:self action:@selector(selectedIndexVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:btn];
        
        UILabel *leftTxet = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.origin.x, 90, btn.frame.size.width, 32)];
        leftTxet.font = [UIFont systemFontOfSize:19.0f];
        leftTxet.text = labelText[i];
        leftTxet.backgroundColor = [UIColor clearColor];
        leftTxet.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:leftTxet];
    }
    
    UIView *lineV1 = [[UIView alloc] initWithFrame:CGRectMake(340, 90, 1, 38)];
    lineV1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineV1];
    
    UIView *lineV2 = [[UIView alloc] initWithFrame:CGRectMake(680, 90, 1, 38)];
    lineV2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineV2];
    
    _slider = [[UIView alloc] initWithFrame:CGRectMake(2, 120, 332, 5)];
    _slider.backgroundColor = [UIColor colorWithRed:0.702 green:0.102 blue:0.227 alpha:1.000];
    [self.view addSubview:_slider];
}

- (void)selectedIndexVC:(UIButton *)sender
{
    NSUInteger btnIndex = [(UIButton *)sender tag]-100;
//  the red line slide
    CGRect sliderFrame = _slider.frame;
    sliderFrame.origin.x = (sliderFrame.size.width+10) * btnIndex+2;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _slider.frame = sliderFrame;
                     }];
    

//  set transition frome current to next view
    UIView * fromView = self.selectedViewController.view;
    UIView * toView = [[self.viewControllers objectAtIndex:btnIndex] view];
    if (fromView == toView) {
        return;
    }

    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        if (finished) {
                            [self setSelectedIndex:btnIndex];
                        }
                    }];
}

@end
