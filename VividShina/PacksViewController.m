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
}
@end

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

@end
