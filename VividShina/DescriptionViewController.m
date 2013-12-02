//
//  DescriptionViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DescriptionViewController.h"
#import "ShareViewController.h"

#define frameONE CGRectMake(74, 420, 171, 43)
#define frameTWO CGRectMake(74, 440, 171, 43)
#define frameTHR CGRectMake(74, 408, 171, 43)
#define frameFOU CGRectMake(74, 424, 171, 43)

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

- (void)configResult
{
    switch (self.myStyle) {
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
    ShareViewController *shareVC = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    
    shareVC.nav = self.navigationController;
    
    [self presentViewController:shareVC animated:YES completion:^{
        ;
    }];
}

@end
