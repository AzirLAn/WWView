//
//  ViewController.m
//  在view绘制图形区分点击事件
//
//  Created by cheBaidu on 2018/4/19.
//  Copyright © 2018年 车佰度. All rights reserved.
//

#import "ViewController.h"
#import "IrregularView.h"
#import "GCD.h"
#import "ListCarInfoViewController.h"
@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) GCDTimer *timer;
@property (nonatomic, strong) UIImageView *imageCar;

@property (nonatomic, strong) UILabel *speedLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 我在改变
    IrregularView *viewType = [[IrregularView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    viewType.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:viewType];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isIn:) name:@"IsIn" object:nil];
    self.imageCar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.imageCar.backgroundColor = [UIColor redColor];
    [viewType addSubview: self.imageCar];
    [self animationStart: self.imageCar];
  
    self.speedLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
    self.speedLab.text = @"123454";
    self.speedLab.hidden = YES;
    [viewType addSubview:self.speedLab];
    
    // init timer
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    
    // timer event
    [self.timer event:^{

        // task
        self.imageCar.hidden = NO;
        self.speedLab.hidden = YES;
        [self animationStart: self.imageCar];

    } timeInterval:NSEC_PER_SEC * 3 delay:NSEC_PER_SEC * 3];
    
    // start timer
    [self.timer start];

    // Do any additional setup after loading the view, typically from a nib.
}

//添加动画
- (void)animationStart:(UIImageView *)imageView {
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.delegate = self;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [imageView.layer addAnimation:animation forKey:nil];
    
}

// 动画停止方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  
    self.imageCar.hidden = YES;
    self.speedLab.hidden = NO;
       
}


- (void)isIn:(NSNotification*)notification{
    
    if ([notification.userInfo[@"IsIn"] isEqualToString:@"In"]) {
        NSLog(@"在里面");
    }else if ([notification.userInfo[@"IsIn"] isEqualToString:@"Out"]){
        NSLog(@"在外面");
        ListCarInfoViewController *vc  =[[ListCarInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
