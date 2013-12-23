
//
//  HomeViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "HomeViewController.h"
#import "BallViewController.h"
#import "LipstickViewController.h"
#import "PacksViewController.h"

@interface HomeViewController ()

@end

#define kNumber 4

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configScrollView];
    [self configButtonShadow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)configButtonShadow
{
    _btn1.layer.shadowOffset = CGSizeMake(0, 3);
    _btn1.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn1.layer.shadowOpacity=0.5;
    

    _btn2.layer.shadowOffset = CGSizeMake(0, 3);
    _btn2.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn2.layer.shadowOpacity=0.5;
    

    _btn3.layer.shadowOffset = CGSizeMake(0, 3);
    _btn3.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn3.layer.shadowOpacity=0.5;
    

}

- (void)configScrollView
{
    _pageControl.numberOfPages = kNumber;

    CGRect kvFrame = _kvScrollView.frame;
    _kvScrollView.pagingEnabled = YES;
    _kvScrollView.delegate = self;
    _kvScrollView.contentSize = CGSizeMake(kvFrame.size.width * kNumber, 0);
    
    for (int i = 0; i < kNumber; i++) {
        UIButton *kvButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [kvButton setFrame:CGRectMake(kvFrame.size.width * i, 0, kvFrame.size.width, kvFrame.size.height)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"home_kv%d.jpg",i+1]];
        [kvButton setImage:image forState:UIControlStateNormal];
        [kvButton setImage:image forState:UIControlStateHighlighted];
        [_kvScrollView addSubview:kvButton];
        
        if (i == 0)
            [kvButton addTarget:self action:@selector(testingStyle:) forControlEvents:UIControlEventTouchUpInside];
        else
            [kvButton addTarget:self action:@selector(limitedGift:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//  set a timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(autoplay:) userInfo:nil repeats:YES];
}

- (void)autoplay:(NSTimer *)timer
{
    CGPoint currentP = _kvScrollView.contentOffset;
    float kvWidth = _kvScrollView.frame.size.width;
    float goingX = 0;
    if (currentP.x >= kvWidth*(kNumber - 1))
        goingX = 0;
    else
        goingX = currentP.x + kvWidth;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [_kvScrollView setContentOffset:CGPointMake(goingX, 0) animated:YES];
                     }];
}


- (IBAction)testingStyle:(id)sender {
    BallViewController *ballVC = [[BallViewController alloc] initWithNibName:@"BallViewController" bundle:nil];
    [self.navigationController pushViewController:ballVC animated:YES];
}

- (IBAction)lipstickSeries:(id)sender {
    LipstickViewController *lipstickVC = [[LipstickViewController alloc] init];
    [self.navigationController pushViewController:lipstickVC animated:YES];
}

- (IBAction)limitedGift:(id)sender {
    PacksViewController *packsVC = [[PacksViewController alloc] initWithNibName:@"PacksViewController" bundle:nil];
    [self.navigationController pushViewController:packsVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
