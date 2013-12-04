//
//  LeftViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
{
    UIButton *_homeBtn;
    NSMutableArray *_buttons;
    NSInteger _indexTag;
    NSArray *_colors;
}
@end

#define kHighLightH 320
#define kNormalH 376

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadFirst];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTwelveLipstick];
    [self loadFirst];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    ;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_homeBtn) {
        _homeBtn = [self creatHomeBtn];
        [self.navigationController.view addSubview:_homeBtn];
    }
}

- (void)loadFirst
{
    _scrollView.contentSize = CGSizeMake(930, 0);
    _indexTag = 10000;
    
    _colors = nil;
    _colors = [[NSArray alloc] init];
    _colors = @[ @[@"HOT CORALLINE",[UIColor colorWithRed:0.933 green:0.510 blue:0.514 alpha:1.000]],
                 @[@"POPPY LOVE",[UIColor colorWithRed:0.929 green:0.200 blue:0.333 alpha:1.000]],
                 @[@"POWER PINK",[UIColor colorWithRed:0.980 green:0.502 blue:0.600 alpha:1.000]],
                 @[@"MAGNETIC MAGENTA",[UIColor colorWithRed:0.765 green:0.051 blue:0.290 alpha:1.000]],
                 @[@"FORBIDDEN APPLE",[UIColor colorWithRed:0.490 green:0.008 blue:0.086 alpha:1.000]],
                 @[@"PINK RIOT",[UIColor colorWithRed:0.878 green:0.318 blue:0.467 alpha:1.000]],
                 @[@"PINK VOLTAGE",[UIColor colorWithRed:0.867 green:0.380 blue:0.471 alpha:1.000]],
                 @[@"FIREBALL",[UIColor colorWithRed:0.871 green:0.173 blue:0.298 alpha:1.000]],
                 @[@"ELECTRIC",[UIColor colorWithRed:0.925 green:0.537 blue:0.722 alpha:1.000]],
                 @[@"MAUVE STRUCK",[UIColor colorWithRed:0.933 green:0.498 blue:0.522 alpha:1.000]],
                 @[@"BRILLIANT BARE",[UIColor colorWithRed:0.886 green:0.553 blue:0.455 alpha:1.000]],
                 @[@"SPIKED TOFFEE",[UIColor colorWithRed:0.773 green:0.557 blue:0.467 alpha:1.000]],
                 ];
    if (_buttons) {
        [self selectColor:_buttons[0]];
    }
}

- (void)creatTwelveLipstick
{
    _buttons = [[NSMutableArray alloc] initWithCapacity:12];
    for (int i = 0; i < 12; i++) {
        NSString *btnName = [NSString stringWithFormat:@"CG%d.png",i+1];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:i+200];
        [btn setImage:[UIImage imageNamed:btnName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnName] forState:UIControlStateHighlighted];
        [btn setFrame:CGRectMake(8+i*75, kNormalH, 89, 322)];
        [btn addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        
        [_buttons addObject:btn];
        }
}

- (void)selectColor:(UIButton *)sender
{
    UIButton *currentBtn = (UIButton *)sender;
    if (currentBtn.tag == _indexTag)
        return;
    _indexTag = currentBtn.tag;
    
    
    [UIView animateWithDuration:0.3f animations:^{
        _colorMouth.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7f
                         animations:^{
                             _colorMouth.alpha = 1;
                         }];
    }];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         for (UIButton *btn in _buttons) {
                             CGRect rect = btn.frame;
                             if (currentBtn == btn) {
                                 rect.origin.y = kHighLightH;
                                 currentBtn.frame = rect;
                                 continue;
                             }
                             rect.origin.y = kNormalH;
                             [btn setFrame:rect];
                         }
                     }completion:^(BOOL finished) {
                         ;
                     }];
    [self configImage:currentBtn.tag-199];
}

- (void)configImage:(NSInteger )indexTag
{
    NSString *mouthName = [NSString stringWithFormat:@"mouth%d.png",indexTag];
    _colorMouth.image = [UIImage imageNamed:mouthName];

    
    _colorWord.textColor = [[_colors objectAtIndex:indexTag-1]objectAtIndex:1];
    _colorWord.text = [[_colors objectAtIndex:indexTag-1]objectAtIndex:0];
    [_colorWord sizeToFit];
    CGRect rectNOW = _colorWord.frame;
    [_colorWord setFrame:CGRectMake(396 - rectNOW.size.width - 44, 670, rectNOW.size.width + 44, 63)];
}

@end
