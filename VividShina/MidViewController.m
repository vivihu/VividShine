//
//  MidViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "MidViewController.h"

@interface MidViewController ()

@end

@implementation MidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadFirst];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadFirst];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFirst
{
    UIButton *firstBtn = (UIButton *)[self.view viewWithTag:10];
    if (firstBtn) {
        [self selectedColor:firstBtn];
    }
}

- (void)configIndexButton:(NSInteger)indexTag
{
    NSString *boxName = [NSString stringWithFormat:@"box%d.png",indexTag/10];
    _box.image = [UIImage imageNamed:boxName];

    NSString *imgName = [NSString stringWithFormat:@"left%d",indexTag/10];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"jpg"];
    _leftYY.image = [UIImage imageWithContentsOfFile:imgPath];
}


- (IBAction)selectedColor:(id)sender {
    for (UIView *subView in [self.view subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [(UIButton *)subView setSelected:NO];
        }
    }
    UIButton *btn = (UIButton *)sender;
    [btn setSelected:YES];


    [self configIndexButton:btn.tag];
}

@end
