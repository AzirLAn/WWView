//
//  ViewController.m
//  在view绘制图形区分点击事件
//
//  Created by cheBaidu on 2018/4/19.
//  Copyright © 2018年 车佰度. All rights reserved.
//

#import "ViewController.h"
#import "IrregularView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IrregularView *viewType = [[IrregularView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    viewType.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:viewType];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isIn:) name:@"IsIn" object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)isIn:(NSNotification*)notification{
    
    if ([notification.userInfo[@"IsIn"] isEqualToString:@"In"]) {
        NSLog(@"在里面");
    }else if ([notification.userInfo[@"IsIn"] isEqualToString:@"Out"]){
        NSLog(@"在外面");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
