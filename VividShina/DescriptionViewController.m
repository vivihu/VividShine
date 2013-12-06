//
//  DescriptionViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DescriptionViewController.h"
#import "VIShareViewController.h"

#define frameONE CGRectMake(74, 420, 171, 43)
#define frameTWO CGRectMake(74, 440, 171, 43)
#define frameTHR CGRectMake(74, 408, 171, 43)
#define frameFOU CGRectMake(74, 424, 171, 43)

@interface DescriptionViewController ()
{
//    UIButton *_backBtn;
    UIButton *_homeBtn;
}

@end

@implementation DescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [self configResult];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configResult];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_homeBtn) {
        _homeBtn = [self creatHomeBtn];
        [_homeBtn setUserInteractionEnabled:NO];
        [self.navigationController.view addSubview:_homeBtn];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_homeBtn) {
        [_homeBtn setUserInteractionEnabled:YES];
    }
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_homeBtn) {
        [_homeBtn removeFromSuperview];
        _homeBtn = nil;
    }
    
    [super viewWillDisappear:animated];
}

- (void)configResult
{
    NSString *imgPath = nil;
    switch (self.myStyle) {
        case style_one:
        {
            [_shareBtn setFrame:frameONE];
            imgPath = [[NSBundle mainBundle] pathForResource:@"one" ofType:@"png"];
        }
            break;
        case style_two:
        {
            [_shareBtn setFrame:frameTWO];
            imgPath = [[NSBundle mainBundle] pathForResource:@"two" ofType:@"png"];
        }
            break;
        case style_three:
        {
            [_shareBtn setFrame:frameTHR];
            imgPath = [[NSBundle mainBundle] pathForResource:@"three" ofType:@"png"];
        }
            break;
        case style_four:
        {
            [_shareBtn setFrame:frameFOU];
            imgPath = [[NSBundle mainBundle] pathForResource:@"four" ofType:@"png"];
        }
            break;

        default:
            break;
    }
    
    [_resultImage setImage:[UIImage imageWithContentsOfFile:imgPath]];
}

- (IBAction)shareToFriend:(id)sender {
    VIShareViewController *shareVC = [[VIShareViewController alloc] initWithNibName:@"VIShareViewController" bundle:nil];
    
    shareVC.nav = self.navigationController;
    shareVC.currentIndex = self.myStyle;
    
    [self presentViewController:shareVC animated:YES completion:^{
        ;
    }];
}

@end
