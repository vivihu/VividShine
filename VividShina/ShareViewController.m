//
//  ShareViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareDoneViewController.h"

@interface ShareViewController ()
{
    ShareDoneViewController *_shareDoneVC;
}
@end

@implementation ShareViewController

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

- (void)enterShareDoneViewController
{
    if (!_shareDoneVC) {
        _shareDoneVC = [[ShareDoneViewController alloc] initWithNibName:@"ShareDoneViewController" bundle:nil];
    }
    [self.nav pushViewController:_shareDoneVC animated:YES];
    [self closeCurrentViewController:nil];
}

- (IBAction)shareToEmail:(id)sender {
    [_scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
}

- (IBAction)shareToQQ:(id)sender {
    
    ;
    [self enterShareDoneViewController];
}

- (IBAction)shareToSina:(id)sender {
    
    ;
    [self enterShareDoneViewController];
}

- (IBAction)shareToWeixin:(id)sender {
    
    ;
    [self enterShareDoneViewController];
}

- (IBAction)sendEmail:(id)sender {
    [self enterShareDoneViewController];
}

- (IBAction)closeCurrentViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


@end
