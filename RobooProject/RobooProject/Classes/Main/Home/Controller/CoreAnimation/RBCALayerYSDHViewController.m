//
//  RBCALayerYSDHViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/10.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCALayerYSDHViewController.h"

#define angle2radion(angle) ((angle) / 180.0 * M_PI)

/*
 动画三步骤：
 1.初始化动画对象
 2.设置需要修改的动画属性的值
 3.把动画添加到layer（所有的动画都是添加在layer上，不是view）

 你看到的都是假象，真正的view是没有发生变化的
 postition:（layer里面设置中心点） center:uiview
 presentationLayer和modelLayer（呈现层和模型层）

 锚点：1.概念；2.单位坐标0-1；3.和position的关系：就是锚点在父视图的位置

 隐式动画：默认时间0.25s(位置，颜色，大小),必须是独立的layer才有隐式动画，uiview（根layer）
 显示动画：
 */

@interface RBCALayerYSDHViewController ()

@end

@implementation RBCALayerYSDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blueLayer.position = CGPointMake(200, 150);

    self.blueLayer.anchorPoint = CGPointZero;

    self.blueLayer.bounds = CGRectMake(0, 0, 80, 80);

    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 旋转
    self.blueLayer.transform = CATransform3DMakeRotation(angle2radion(arc4random_uniform(360) + 1), 0, 0, 1);
    self.blueLayer.position = CGPointMake(arc4random_uniform(200) + 20, arc4random_uniform(400) + 50);
    self.blueLayer.cornerRadius = arc4random_uniform(50);
    self.blueLayer.backgroundColor = [UIColor RandomColor].CGColor;
    self.blueLayer.borderWidth = arc4random_uniform(10);
    self.blueLayer.borderColor = [UIColor RandomColor].CGColor;


    [UIAlertController rb_showAlertWithTitle:@"隐式动画的frame " message:[NSString stringWithFormat:@"self.redView.frame = %@", NSStringFromCGRect(self.blueLayer.frame)]  appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {

        alertMaker.addActionDefaultTitle(@"确认");

    } actionsBlock:nil];
}

@end
