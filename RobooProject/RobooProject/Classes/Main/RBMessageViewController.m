//
//  RBMessageViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBMessageViewController.h"
#import "RBRACProjectViewController.h"
#import "WhackACacViewController.h"


@interface RBMessageViewController ()

/** 返回按键 */
@property (weak, nonatomic) UILabel *backBtn;

@end

@implementation RBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RBWeak(self);
    NSLog(@"%@", weakself);
    self.navigationItem.title = @"功能实例";

    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.rb_height;
    self.tableView.contentInset = edgeInsets;

    RBWordItem *itemRAC = [RBWordItem itemWithTitle:@"RAC登陆实例" subTitle: @"RAC"];
    [itemRAC setItemOperation:^(NSIndexPath *indexPath){
        [weakself presentViewController:[[RBNavigationController alloc] initWithRootViewController:[[RBRACProjectViewController alloc] init]] animated:YES completion:nil];
    }];

    RBWordItem *itemWhackCac = [RBWordItem itemWithTitle:@"打地鼠" subTitle: @"WhackCac"];
    [itemWhackCac setItemOperation:^(NSIndexPath *indexPath){
        
        [weakself presentViewController:[[RBNavigationController alloc] initWithRootViewController:[[WhackACacViewController alloc] init]] animated:YES completion:nil];
    }];

    RBItemSection *section0 = [RBItemSection sectionWithItems:@[itemRAC,itemWhackCac] andHeaderTitle:nil footerTitle:nil];

    [self.sections addObject:section0];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.backBtn.hidden = !self.presentedViewController;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.backBtn.hidden = !self.presentedViewController;
}

- (UILabel *)backBtn
{
    if(_backBtn == nil)
    {
        UILabel *btn = [[UILabel alloc] init];
        btn.text = @"点击返回";
        btn.font = AdaptedFontSize(10);
        btn.textColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];;
        btn.textAlignment = NSTextAlignmentCenter;
        btn.userInteractionEnabled = YES;
        [btn sizeToFit];
        [btn setFrame:CGRectMake(20, 100, btn.rb_width + 20, 30)];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;

        RBWeak(self);
        [btn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {

            if (weakself.presentedViewController) {
                [weakself.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }

        }];


        RBWeak(btn);
        [btn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer  *_Nonnull sender) {

            //            NSLog(@"%@", sender);

            // 获取手势的触摸点
            // CGPoint curP = [pan locationInView:self.imageView];

            // 移动视图
            // 获取手势的移动，也是相对于最开始的位置
            CGPoint transP = [sender translationInView:weakbtn];

            weakbtn.transform = CGAffineTransformTranslate(weakbtn.transform, transP.x, transP.y);

            // 复位
            [sender setTranslation:CGPointZero inView:weakbtn];

            if (sender.state == UIGestureRecognizerStateEnded) {

                [UIView animateWithDuration:0.2 animations:^{

                    weakbtn.rb_x = (weakbtn.rb_x - kScreenWidth / 2) > 0 ? (kScreenWidth - weakbtn.rb_width - 20) : 20;
                    weakbtn.rb_y = weakbtn.rb_y > 80 ? weakbtn.rb_y : 80;
                }];
            }

        }]];

        [[UIApplication sharedApplication].keyWindow addSubview:btn];

        _backBtn = btn;
    }
    return _backBtn;
}

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}

//支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
