//
//  MidViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidViewController : UIViewController
{
    IBOutlet UIButton *_brownBtn;
    IBOutlet UIButton *_purpleBtn;
    IBOutlet UIButton *_pinkBtn;
    IBOutlet UIButton *_goldBtn;
    
    IBOutlet UIImageView *_box;
}

- (IBAction)selectedColor:(id)sender;

@end
