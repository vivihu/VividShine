//
//  RootViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (UIButton *)creatBackBtn
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"back.jpg"] forState:UIControlStateNormal];
    [back setFrame:CGRectMake(10, 10, 57, 57)];
    [back addTarget:self action:@selector(backStep) forControlEvents:UIControlEventTouchUpInside];
    return back;
}

- (void)backStep
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)creatHomeBtn
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"home.jpg"] forState:UIControlStateNormal];
    [back setFrame:CGRectMake(1024-68, 12, 55, 55)];
    [back addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    return back;
}

- (void)backToHome:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_backBtn) {
        _backBtn = [self creatBackBtn];
        [_backBtn setUserInteractionEnabled:NO];
        [self.navigationController.view addSubview:_backBtn];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_backBtn) {
        [_backBtn setUserInteractionEnabled:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_backBtn) {
        [_backBtn removeFromSuperview];
        _backBtn = nil;
    }
}

@end
