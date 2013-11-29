//
//  DescriptionViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DescriptionViewController.h"

#define frameONE CGRectMake(138, 394, 164, 35)
#define frameTWO CGRectMake(138, 388, 164, 35)
#define frameTHR CGRectMake(138, 386, 164, 35)
#define frameFOU CGRectMake(74, 420, 164, 35)

@interface DescriptionViewController ()
{
    UIButton *_backBtn;
}

@end

@implementation DescriptionViewController

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
    if (!_backBtn) {
        _backBtn = [self creatBackBtn];
        [self.navigationController.view addSubview:_backBtn];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_backBtn removeFromSuperview];
    _backBtn = nil;
}

- (void)configResult:(MyStyle )mystyle
{
    switch (mystyle) {
        case style_one:
        {
            [_shareBtn setFrame:frameONE];
            [_resultImage setImage:[UIImage imageNamed:@"one"]];
        }
            break;
        case style_two:
        {
            [_shareBtn setFrame:frameTWO];
            [_resultImage setImage:[UIImage imageNamed:@"two"]];
        }
            break;
        case style_three:
        {
            [_shareBtn setFrame:frameTHR];
            [_resultImage setImage:[UIImage imageNamed:@"three"]];
        }
            break;
        case style_four:
        {
            [_shareBtn setFrame:frameFOU];
            [_resultImage setImage:[UIImage imageNamed:@"four"]];
        }
            break;

        default:
            break;
    }
}

- (IBAction)shareToFriend:(id)sender {
    NSLog(@"share button");
}

@end
