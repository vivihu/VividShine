//
//  PacksViewController.h
//  VividShina
//
//  Created by icreative-mini on 13-11-30.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "RootViewController.h"
#import "SwipeView.h"

@interface PacksViewController : RootViewController<SwipeViewDataSource,SwipeViewDelegate>
{
    IBOutlet UIPageControl *_pageControl;
    
    SwipeView *_textSwipeView;
    SwipeView *_imageSwipeView;
    
    NSArray *_textData;
    NSArray *_imageData;
}

@end
