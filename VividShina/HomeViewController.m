
//
//  HomeViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "HomeViewController.h"
#import "BallViewController.h"

@interface HomeViewController ()

@end

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)configScrollView
{
    CGRect kvFrame = _kvScrollView.frame;
    _kvScrollView.pagingEnabled = YES;
    _kvScrollView.delegate = self;
    _kvScrollView.contentSize = CGSizeMake(kvFrame.size.width * 4, 0);
    
    for (int i = 0; i < 4; i++) {
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
}

- (IBAction)testingStyle:(id)sender {
    BallViewController *ballVC = [[BallViewController alloc] initWithNibName:@"BallViewController" bundle:nil];
    [self.navigationController pushViewController:ballVC animated:YES];
}

- (IBAction)lipstickSeries:(id)sender {
    ;
}

- (IBAction)limitedGift:(id)sender {
    NSLog(@"limitedGift");;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
