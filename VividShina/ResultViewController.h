//
//  ResultViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ResultViewController : RootViewController
{
    IBOutlet UILabel *_SSGX;
    IBOutlet UILabel *_FYNQ;
    IBOutlet UILabel *_RHQT;
    IBOutlet UILabel *_YZYY;
    IBOutlet UILabel *_texts;
}

@property (nonatomic,strong) NSDictionary *dataDic;

- (IBAction)nextStep:(id)sender;

@end
