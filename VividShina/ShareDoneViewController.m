//
//  ShareDoneViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-12-2.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ShareDoneViewController.h"
#import "LipstickViewController.h"

@interface ShareDoneViewController ()
{
    UIButton *_homeBtn;
}
@end

@implementation ShareDoneViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_homeBtn) {
        _homeBtn = [self creatHomeBtn];
        [self.navigationController.view addSubview:_homeBtn];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_homeBtn removeFromSuperview];
    _homeBtn = nil;
}

- (IBAction)lipstickSeries:(id)sender {
    LipstickViewController *lipstickVC = [[LipstickViewController alloc] init];
    [self.navigationController pushViewController:lipstickVC animated:YES];
}

@end
