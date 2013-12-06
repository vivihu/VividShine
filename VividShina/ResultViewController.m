//
//  ResultViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ResultViewController.h"
#import "DescriptionViewController.h"

@interface ResultViewController ()
{
//    UIButton *_backBtn;
    UIButton *_homeBtn;
}

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [self setLabelText];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self textTwinkling];

    //   ios7 下调用
    [self setLabelText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_homeBtn) {
        _homeBtn = [self creatHomeBtn];
        [_homeBtn setUserInteractionEnabled:NO];
        [self.navigationController.view addSubview:_homeBtn];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_homeBtn) {
        [_homeBtn setUserInteractionEnabled:YES];
    }
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_homeBtn) {
        [_homeBtn removeFromSuperview];
        _homeBtn = nil;
    }
    
    [super viewWillDisappear:animated];
}

- (void)setLabelText
{
    _SSGX.text  =   [NSString stringWithFormat:@"%d",[[self.dataDic objectForKey:@"third"] intValue] * 20];
    _FYNQ.text  =   [NSString stringWithFormat:@"%d",[[self.dataDic objectForKey:@"fourth"] intValue] * 20];
    _RHQT.text  =   [NSString stringWithFormat:@"%d",[[self.dataDic objectForKey:@"first"] intValue] * 20];
    _YZYY.text  =   [NSString stringWithFormat:@"%d",[[self.dataDic objectForKey:@"sec"] intValue] * 20];
}


- (void)textTwinkling
{
    [_texts.layer removeAllAnimations];
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.delegate = self;
    theAnimation.duration = 1;
    theAnimation.repeatCount = INT_MAX;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.autoreverses = YES;
    theAnimation.fromValue = @0.3f;
    theAnimation.toValue = @1.0f;
    [_texts.layer addAnimation:theAnimation forKey:@"opacity"];
}

- (MyStyle )CalculateTheStyle
{
    int one = [[self.dataDic objectForKey:@"first"] intValue];
    int two = [[self.dataDic objectForKey:@"sec"] intValue];
    int thr = [[self.dataDic objectForKey:@"third"] intValue];
    int fou = [[self.dataDic objectForKey:@"fourth"] intValue];

    
    NSInteger a = MAX(one, two);
    a = MAX(a, thr);
    a = MAX(a, fou);
    
    if (a == one)
        return style_one;
    else if (a == two)
        return style_two;
    else if (a == thr)
        return style_three;
    else
        return style_four;
}

- (IBAction)nextStep:(id)sender {
    DescriptionViewController *desVC = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" bundle:nil];

    desVC.myStyle = [self CalculateTheStyle];

    [self.navigationController pushViewController:desVC animated:YES];
}

@end
