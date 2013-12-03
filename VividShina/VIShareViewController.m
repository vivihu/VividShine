//
//  ShareViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "VIShareViewController.h"
#import "ShareDoneViewController.h"
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>


@interface VIShareViewController ()
{
    ShareDoneViewController *_shareDoneVC;
    UIAlertView *_successView;
}
@end

@implementation VIShareViewController

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
    [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self enterShareDoneViewController];
}


#pragma mark - custom method
- (void)enterShareDoneViewController
{
    if (!_shareDoneVC) {
        _shareDoneVC = [[ShareDoneViewController alloc] initWithNibName:@"ShareDoneViewController" bundle:nil];
    }
    [self.nav pushViewController:_shareDoneVC animated:YES];
    [self closeCurrentViewController:nil];
}

- (void)resultTip:(ShareType)type withResult:(BOOL)success
{
    NSString *title = nil;
    switch (type) {
        case ShareTypeSinaWeibo:
            title = @"新浪微博";
            break;
        case ShareTypeTencentWeibo:
            title = @"腾讯微博";
            break;
        case ShareTypeWeixiTimeline:
            title = @"微信好友圈";
            break;
        case ShareTypeMail:
            title = @"邮件";
            break;

        default:
            break;
    }
    if (!success) {
        UIAlertView *view =
        [[UIAlertView alloc] initWithTitle:title
                                   message:@"分享失败"
                                  delegate:nil
                         cancelButtonTitle:@"知道了"
                         otherButtonTitles:nil];
        [view show];
    }else {
        UIAlertView *view =
        [[UIAlertView alloc] initWithTitle:title
                                   message:@"分享成功！"
                                  delegate:self
                         cancelButtonTitle:@"知道了"
                         otherButtonTitles:nil];
        [view show];
    }
}

- (IBAction)shareToEmail:(id)sender {
    [_scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
}

- (IBAction)sendEmail:(id)sender {
    
    ;
    [self enterShareDoneViewController];
}


- (IBAction)shareToFriend:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ShareType type;
    if (btn.tag == 1001)
        type = ShareTypeTencentWeibo;
    else if (btn.tag == 1002)
        type = ShareTypeSinaWeibo;
    else {
        if (![WXApi isWXAppInstalled]) {
            UIAlertView *view =
            [[UIAlertView alloc] initWithTitle:@"提示"
                                       message:@"不能在没有安装微信的设备上正确运行！"
                                      delegate:nil
                             cancelButtonTitle:@"知道了"
                             otherButtonTitles: nil];
            [view show];
            return;
        }
        type = ShareTypeWeixiTimeline;
    }
    
    
    id<ISSContent> publishContent = nil;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    NSString *contentString = [NSString stringWithFormat:@"测试分享内容       %@",dateStr];
    NSString *titleString   = @"微信分享集成测试";
    NSString *urlString     = nil;
    NSString *description   = nil;
    publishContent = [ShareSDK content:contentString
                        defaultContent:@""
                                 image:nil
                                 title:titleString
                                   url:urlString
                           description:description
                             mediaType:SSPublishContentMediaTypeText];

//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:NO
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:titleString
//                                                              oneKeyShareList:nil
//                                                               qqButtonHidden:YES
//                                                        wxSessionButtonHidden:YES
//                                                       wxTimelineButtonHidden:YES
//                                                         showKeyboardOnAppear:NO
//                                                            shareViewDelegate:nil
//                                                          friendsViewDelegate:nil
//                                                        picViewerViewDelegate:nil];

    [ShareSDK shareContent:publishContent
                      type:type
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type,
                             SSResponseState state,
                             id<ISSPlatformShareInfo> statusInfo,
                             id<ICMErrorInfo> error,
                             BOOL end){
                        if (state == SSResponseStateSuccess) {
                            [self resultTip:type withResult:YES];
                        }
                        else if (state == SSResponseStateFail) {
                            [self resultTip:type withResult:NO];
                        }
                    }];
}

- (IBAction)closeCurrentViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


@end
