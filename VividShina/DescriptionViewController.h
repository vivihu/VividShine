//
//  DescriptionViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

typedef enum {
    style_one = 0,
    style_two,
    style_three,
    style_four
} MyStyle;

@interface DescriptionViewController : RootViewController
{
    IBOutlet UIImageView *_resultImage;
    IBOutlet UIButton *_shareBtn;
}

@property (nonatomic) MyStyle myStyle;

- (IBAction)shareToFriend:(id)sender;

@end
