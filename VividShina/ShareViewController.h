//
//  ShareViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
{
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UITextField *_EmailField;
}

@property (nonatomic, strong) UINavigationController *nav;

- (IBAction)shareToEmail:(id)sender;
- (IBAction)shareToQQ:(id)sender;
- (IBAction)shareToSina:(id)sender;
- (IBAction)shareToWeixin:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)closeCurrentViewController:(id)sender;

@end
