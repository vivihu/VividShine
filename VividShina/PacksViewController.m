//
//  PacksViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-30.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "PacksViewController.h"

@interface PacksViewController ()
{
    UIButton *_homeBtn;
    UIView *_slider;
    
    NSInteger _pageNumber;
}
@end

#define kPageOne 4
#define kPageTwo 4
#define kPageThr 2

@implementation PacksViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_homeBtn) {
        _homeBtn = [self creatHomeBtn];
        [self.navigationController.view addSubview:_homeBtn];
    }
}

- (void)initData
{
    [self creatTabBar];
    [self creatSwipeView];
    
    _pageNumber = 0;
    _pageControl.numberOfPages = kPageOne;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view bringSubviewToFront:_pageControl];
    

    _textData = [[NSArray alloc] initWithObjects:
                 @"1_1",
                 @"1_2",
                 @"1_3",
                 @"1_4",
                 @"2_1",
                 @"2_2",
                 @"2_3",
                 @"2_4",
                 @"3_1",
                 @"3_2",
                 nil];
    
    _imageData = [[NSArray alloc] initWithObjects:
                  @"pack_kv1",
                  @"pack_kv2",
                  @"pack_kv3",
                  @"pack_kv4",
                  @"pack_kv5",
                  @"pack_kv6",
                  @"pack_kv7",
                  @"pack_kv8",
                  @"pack_kv11",
                  @"pack_kv12",
                  nil];
}

- (void)creatSwipeView
{
    _textSwipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 128, 308, 640)];
    _textSwipeView.dataSource = self;
    _textSwipeView.userInteractionEnabled = NO;
    _textSwipeView.pagingEnabled = YES;
    [self.view addSubview:_textSwipeView];
    
    _imageSwipeView = [[SwipeView alloc] initWithFrame:CGRectMake(312, 128, 712, 640)];
    _imageSwipeView.dataSource = self;
    _imageSwipeView.delegate = self;
    _imageSwipeView.pagingEnabled = YES;
    _imageSwipeView.delaysContentTouches = NO;
    [self.view addSubview:_imageSwipeView];
}

- (void)creatTabBar
{
    NSArray *labelText = @[ @"明 媚 彩 妆",
                            @"完 美 护 肤",
                            @"优 雅 香 氛"
                            ];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(1+i*340, 84, 340, 44)];
        [btn setTag:i+200];
        [btn addTarget:self action:@selector(selectedIndexView:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)selectedIndexView:(UIButton *)sender
{
    NSUInteger btnIndex = [(UIButton *)sender tag]-200;
    [self setSliderRectIndex:btnIndex];
    
    if (btnIndex == 0)
        [_imageSwipeView scrollToPage:0 duration:0.5f];
    else if (btnIndex == 1)
        [_imageSwipeView scrollToPage:kPageOne duration:0.5f];
    else if (btnIndex == 2)
        [_imageSwipeView scrollToPage:kPageOne+kPageTwo duration:0.5f];
}

- (void)setSliderRectIndex:(NSInteger)btnIndex
{
    CGRect sliderFrame = _slider.frame;
    sliderFrame.origin.x = (sliderFrame.size.width+10) * btnIndex+2;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _slider.frame = sliderFrame;
                     }];
}

#pragma mark - SwipeViewDataSource
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return _textData.count;// or _imageData.count
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imgView = (UIImageView *)view;
    NSString *imgPath = nil;
    
    if (swipeView == _textSwipeView) {
        if (view == nil)
        {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 308.f, 640.f)];
            view = imgView;
        }
        imgPath = [[NSBundle mainBundle] pathForResource:_textData[index] ofType:@"png"];
    }
    else {
        if (view == nil)
        {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 712.f, 640.f)];
            view = imgView;
        }
        imgPath = [[NSBundle mainBundle] pathForResource:_imageData[index] ofType:@"jpg"];
    }
    
    imgView.image = [UIImage imageWithContentsOfFile:imgPath];

    return view;
}

- (void)scrollToIndexPage:(NSInteger)indexPage
{
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.currentPage = indexPage - _pageNumber;
    [_textSwipeView scrollToPage:indexPage duration:0.3f];
}

#pragma mark SwipeViewDelegate
- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    [self scrollToIndexPage:swipeView.currentPage];
}

- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView
{
    [self scrollToIndexPage:swipeView.currentPage];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    NSInteger indexPage = swipeView.currentPage;
    if (indexPage < kPageOne) {
        _pageNumber = 0;
        _pageControl.numberOfPages = kPageOne;
        [self setSliderRectIndex:0];
    }
    else if (indexPage >= kPageOne && indexPage < kPageOne+kPageTwo) {
        _pageNumber = kPageOne;
        _pageControl.numberOfPages = kPageTwo;
        [self setSliderRectIndex:1];
    }
    else {
        _pageNumber = kPageOne+kPageTwo;
        _pageControl.numberOfPages = kPageThr;
        [self setSliderRectIndex:2];
    }
    
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
}

@end
