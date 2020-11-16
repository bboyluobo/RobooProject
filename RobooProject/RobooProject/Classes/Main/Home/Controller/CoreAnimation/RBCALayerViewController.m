//
//  RBCALayerViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/10.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCALayerViewController.h"

@interface RBCALayerViewController ()<CAAnimationDelegate>

@end

@implementation RBCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self.view makeToast:@"点击屏幕" duration:3 position:CSToastPositionCenter];
}


- (UIView *)redView {
    if (!_redView) {
        UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(70, 120, 150, 200)];
        [self.view addSubview:redView];
        _redView = redView;
        redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}


- (CALayer *)blueLayer{
    if (!_blueLayer) {
        CALayer * blueLayer = [CALayer layer];
        [self.view.layer addSublayer:blueLayer];
        blueLayer.backgroundColor = [UIColor blueColor].CGColor;
        _blueLayer = blueLayer;
        blueLayer.frame = CGRectMake(70, 370, 100, 150);
    }
    return _blueLayer;
}

#pragma mark - RBNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];

    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - RBNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start:redView-%@",NSStringFromCGRect(self.redView.frame));
    NSLog(@"start:blueLayer-%@",NSStringFromCGRect(self.blueLayer.frame));
}

//hittest
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"stop:redeView-%@",NSStringFromCGRect(self.redView.layer.modelLayer.frame));
    NSLog(@"stop:blueLayer-%@",NSStringFromCGRect(self.blueLayer.modelLayer.frame));
}

@end
