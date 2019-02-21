//
//  RBCAKeyFrameViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCAKeyFrameViewController.h"

@interface RBCAKeyFrameViewController ()

@end

@implementation RBCAKeyFrameViewController

- (void)loadView {
    self.view = [[RBDrawView alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueLayer.bounds = CGRectMake(0, 0, 50, 50);
    self.blueLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.blueLayer.contents = (id)[UIImage imageNamed:@"tabBar_me_click_icon"].CGImage;
    [MBProgressHUD showAutoMessage:@"请手指移动画线"];
}

@end


@interface RBDrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation RBDrawView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // touch
    UITouch *touch = [touches anyObject];
    //point
    CGPoint point = [touch locationInView:self];
    //创建路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    _path = path;
    //设置起点
    [_path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // touch
    UITouch *touch = [touches anyObject];
    //point
    CGPoint point = [touch locationInView:self];

    //绘画路径
    [_path addLineToPoint:point];
    //根据设置的点 连线
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL isValue;
    // 给imageView添加核心动画
    // 添加核心动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];

    anim.keyPath = @"position";
    // values

    if (isValue) {
        anim.values = @[@(100),@(-100),@(100)];
        isValue = NO;
    }else {
        // path
        anim.path = _path.CGPath;
        isValue = YES;
    }
    //翻转动画
    anim.autoreverses = YES;
    //动画时间
    anim.duration = 3;
    //动画次数
    anim.repeatCount = MAXFLOAT;
    [[(RBCAKeyFrameViewController *)self.viewController blueLayer] addAnimation:anim forKey:nil];
}

- (void)drawRect:(CGRect)rect {
    //根据设置的点 连线
    [_path stroke];
}

@end
