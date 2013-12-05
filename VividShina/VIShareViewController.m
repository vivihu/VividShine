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
//#import <MailCore/MailCore.h>
#import <AFNetworking/AFNetworking.h>
#import "MobClick.h"

@interface VIShareViewController ()
{
    ShareDoneViewController *_shareDoneVC;
    UIAlertView *_successView;
    NSArray *_weixinImages;
    NSArray *_event;
    UIActivityIndicatorView *_activeView;
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
    _mainQueue = [[NSOperationQueue alloc] init];
    [_mainQueue setMaxConcurrentOperationCount:5];
    
    _weixinImages = [[NSArray alloc] initWithObjects:
    @"http://www.el-lady.com.cn/vividshine2013/app/share1.html",
    @"http://www.el-lady.com.cn/vividshine2013/app/share4.html",
    @"http://www.el-lady.com.cn/vividshine2013/app/share3.html",
    @"http://www.el-lady.com.cn/vividshine2013/app/share2.html",nil];
    
    _event = [[NSArray alloc] initWithObjects:
              @"234942",
              @"234963",
              @"234982",
              @"234962", nil];
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
- (UIView *)addShadowView
{
    UIView *shadow = [[UIView alloc] initWithFrame:self.view.bounds];
    shadow.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5f];
    [self.view addSubview:shadow];
    
    _activeView = [[UIActivityIndicatorView alloc] init];
    _activeView.center = CGPointMake(1024/2, 768/2);
    [_activeView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:_activeView];
    [_activeView startAnimating];

    return shadow;
}

- (void)enterShareDoneViewController
{
    if (!_shareDoneVC) {
        _shareDoneVC = [[ShareDoneViewController alloc] initWithNibName:@"ShareDoneViewController" bundle:nil];
    }
    [self.nav pushViewController:_shareDoneVC animated:YES];
    [self closeCurrentViewController:nil];
}

- (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
    if (success) {
        UIAlertView *view =
        [[UIAlertView alloc] initWithTitle:title
                                   message:@"分享成功！"
                                  delegate:self
                         cancelButtonTitle:@"知道了"
                         otherButtonTitles:nil];
        [view show];
    }
//    else {
//        UIAlertView *view =
//        [[UIAlertView alloc] initWithTitle:title
//                                   message:@"分享失败"
//                                  delegate:nil
//                         cancelButtonTitle:@"知道了"
//                         otherButtonTitles:nil];
//        [view show];
//    }
}

- (void)requestURL:(NSURL *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSLog(@"data === %@, response === %@, error === %@",
          [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],
          response,
          error);
    if ((response.URL == _sendURL) && !error) {
        [self resultTip:ShareTypeMail withResult:YES];
    }

//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:_mainQueue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               ;
//                           }];
}

- (IBAction)shareToEmail:(id)sender {
    [_scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
}

- (IBAction)sendEmail:(id)sender
{
    if (![self isValidateEmail:_EmailField.text]) {
        UIAlertView *unvalidateEmail = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确的邮件格式" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [unvalidateEmail show];
        return;
    }

    [_EmailField resignFirstResponder];
    UIView *shadow = [self addShadowView];
    //    友盟检测代码（记录邮箱）
    [MobClick event:@"email" label:_EmailField.text];

    
    NSURL *url = [NSURL URLWithString:@"https://ebm.cheetahmail.com/api/login1?name=el_cn@api&cleartext=Cheetah!"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:_mainQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"connectionError === %@",connectionError);
        if (connectionError){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_activeView setHidesWhenStopped:YES];
                [shadow removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            });
            return ;
        }
        
        NSString *urlStr = [NSString stringWithFormat:@"https://ebm.cheetahmail.com/ebm/ebmtrigger1?aid=2077265562&email=%@&eid=%@",_EmailField.text,_event[self.currentIndex - 1]];
        NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [NSURLConnection sendAsynchronousRequest:urlReq queue:_mainQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [_activeView setHidesWhenStopped:YES];
            [shadow removeFromSuperview];
            NSLog(@"%d",[NSThread isMainThread]);
            if (!connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self resultTip:ShareTypeMail withResult:YES];
                });
            }
        }];
    }];
}


//- (IBAction)sendEmail:(id)sender {
//    if (![self isValidateEmail:_EmailField.text]) {
//        UIAlertView *unvalidateEmail = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确的邮件格式" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [unvalidateEmail show];
//        return;
//    }
//    UIView *shadowView = [self addShadowView];
//    
//    [_EmailField resignFirstResponder];
//    //    友盟检测代码（记录邮箱）
//    [MobClick event:@"email" label:_EmailField.text];
//    
//    
//
//    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
//    smtpSession.hostname = @"smtp.exmail.qq.com";
//    smtpSession.port = 465;
//    smtpSession.username = @"huweiwei@i-creative.cn";
//    smtpSession.password = @"hww0617";
//    smtpSession.authType = MCOAuthTypeSASLPlain;
//    smtpSession.connectionType = MCOConnectionTypeTLS;
//    
//    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
//    MCOAddress *from = [MCOAddress addressWithDisplayName:@"wei"
//                                                  mailbox:@"huweiwei@i-creative.cn"];
//    MCOAddress *to = [MCOAddress addressWithDisplayName:nil
//                                                mailbox:_EmailField.text];
//    [[builder header] setFrom:from];
//    [[builder header] setTo:@[to]];
//
///********************* 邮  件  内  容 *******************************/
//    NSData *data = [NSData dataWithContentsOfFile:self.currentImagePath];
//    [[builder header] setSubject:@"琉光主角唇膏"];
////    [builder setAttachments:@[data]];
//    NSString *path = [NSString stringWithFormat:@"<div><img src=\"%@\"  alt="" /> Here's the message I need to send.</div>",self.currentImagePath];
//    [builder setHTMLBody:path];
///*******************我 是 一 条 分 割 线********************************/
//    NSData * rfc822Data = [builder data];
//    MCOSMTPSendOperation *sendOperation =
//    [smtpSession sendOperationWithData:rfc822Data];
//    [sendOperation start:^(NSError *error) {
//        if(error) {
//            [self resultTip:ShareTypeMail withResult:NO];
//        } else {
//            [self resultTip:ShareTypeMail withResult:YES];
//        }
//        
//        [shadowView removeFromSuperview];
//    }];
//}

- (IBAction)shareToFriend:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    ShareType type;
    id<ISSCAttachment> image;
    NSString *str = [NSString stringWithFormat:@"share%d",self.currentIndex];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:str ofType:@"jpg"];

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
        imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"jpg"];
    }
    
    id<ISSContent> publishContent = nil;
    //  设置日期格式
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    //  分享内容
    NSString *contentString = [NSString stringWithFormat:@"#琉光主角 唇动心弦#我已找到专属于我的琉光唇色，在节日季，上演绝色致雅，前往@雅诗兰黛 专柜体验琉光主角绚色妆容，亲吻琉光满溢。      ——%@",dateStr];
    image = [ShareSDK imageWithPath:imagePath];
    NSString *titleString   = @"琉光主角唇膏";
    NSString *urlString     = _weixinImages[self.currentIndex-1];
    NSString *description   = nil;

    publishContent = [ShareSDK content:contentString
                        defaultContent:contentString
                                 image:image
                                 title:titleString
                                   url:urlString
                           description:description
                             mediaType:SSPublishContentMediaTypeNews
                      ];

    [ShareSDK shareContent:publishContent
                      type:type
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type,
                             SSResponseState state,
                             id<ISSPlatformShareInfo> statusInfo,
                             id<ICMErrorInfo> error,
                             BOOL end) {
                        if (state == SSResponseStateSuccess) {
                            [self resultTip:type withResult:YES];
                        }
                        else if (state == SSResponseStateFail) {
//                            [self resultTip:type withResult:NO];
                        }else if (state == SSResponseStateCancel) {
                            ;// 仅微信取消可以调到
                        }
                    }];
}

- (IBAction)closeCurrentViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (void)dealloc
{
    [_mainQueue cancelAllOperations];
}

@end
