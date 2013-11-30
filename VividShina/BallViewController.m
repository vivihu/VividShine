//
//  BallViewController.m
//  VividShina
//
//  Created by icreative-mini on 13-11-28.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "BallViewController.h"
#import "ResultViewController.h"

@interface BallViewController ()
{
    UIButton *_backBtn;
    int first, sec, third, fourth;
}
@end

@implementation BallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _selectedBalls = [[NSMutableArray alloc] initWithCapacity:5];
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


- (NSDictionary *)configResult
{
    NSDictionary *dic = nil;
    first = sec = third = fourth = 0;
    for (NSNumber *number in _selectedBalls) {
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
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           [NSNumber numberWithInt:first],@"first",
           [NSNumber numberWithInt:sec],@"sec",
           [NSNumber numberWithInt:third],@"third",
           [NSNumber numberWithInt:fourth],@"fourth",
           nil];
    return dic;
}

- (IBAction)selectType:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    if (balls >= 5 && ![btn isSelected]){
        return;
    }
    
    [btn setSelected:!btn.selected];
    NSNumber *indexTag = [NSNumber numberWithInteger:btn.tag];
    
    if (btn.selected){
        balls++;
        [_selectedBalls addObject:indexTag];
    }
    else{
        balls--;
        [_selectedBalls removeObject:indexTag];
    }
    optionalBall.text = [NSString stringWithFormat:@"%d",5-balls];
    if (balls >= 5) {
        ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        
        resultVC.dataDic = [self configResult];
        
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}

@end
