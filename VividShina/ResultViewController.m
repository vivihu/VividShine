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
    UIButton *_backBtn;
    int first, sec, third, fourth;
}

@end

@implementation ResultViewController

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
    if (!_backBtn) {
        _backBtn = [self creatBackBtn];
        [self.navigationController.view addSubview:_backBtn];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_backBtn removeFromSuperview];
    _backBtn = nil;
}

- (void)setLabelText
{
    One.text    =   [NSString stringWithFormat:@"%d",third * 20];
    two.text    =   [NSString stringWithFormat:@"%d",fourth * 20];
    three.text  =   [NSString stringWithFormat:@"%d",first * 20];
    four.text   =   [NSString stringWithFormat:@"%d",sec * 20];
}

- (void)configResult:(NSMutableArray *)seletedBalls
{
//    NSLog(@"%@",seletedBalls);
    for (NSNumber *number in seletedBalls) {
        int num = number.intValue;
        
        if (num > 10 && num < 20)
            first++;
        
        else if (num > 20 && num < 30)
            sec++;
        
        else if (num > 30 && num < 40)
            third++;

        else if (num > 40 && num < 50)
            fourth++;
    }
    //   ios6 下调用
    [self setLabelText];
}

- (IBAction)nextStep:(id)sender {
    DescriptionViewController *desVC = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" bundle:nil];
    [self.navigationController pushViewController:desVC animated:YES];
    
    [desVC configResult:style_two];;
}

@end
