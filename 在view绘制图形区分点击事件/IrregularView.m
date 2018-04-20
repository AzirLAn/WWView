//
//  IrregularView.m
//  在view绘制图形区分点击事件
//
//  Created by cheBaidu on 2018/4/19.
//  Copyright © 2018年 车佰度. All rights reserved.
//

#import "IrregularView.h"
@interface IrregularView ()
@property (nonatomic ,strong)UIBezierPath *path;
@property (nonatomic ,strong)NSString *isIn;

@end
@implementation IrregularView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (void)drawRect:(CGRect)rect {
   
        self.path=[[UIBezierPath alloc]init];
        self.path.lineWidth = 1;
        self.path.lineCapStyle=kCGLineCapButt;
        self.path.lineJoinStyle=kCGLineJoinBevel;
        [self.path moveToPoint:CGPointMake(1, 1)];
        [self.path addLineToPoint:CGPointMake(200, 1)];
        [self.path addLineToPoint:CGPointMake(120, 199)];
        [self.path addLineToPoint:CGPointMake(1, 199)];
        [self.path addLineToPoint:CGPointMake(1, 199)];
        [self.path closePath];
        [self.path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    if (CGPathContainsPoint(self.path.CGPath, NULL, point, NO)) {
    
        self.isIn = @"In";
        
    }else {

         self.isIn = @"Out";
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"IsIn" object:nil userInfo:@{@"IsIn":self.isIn}];
}

@end

