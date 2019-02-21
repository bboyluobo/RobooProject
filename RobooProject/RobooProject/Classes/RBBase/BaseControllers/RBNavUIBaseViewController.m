//
//  RBNavUIBaseViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBNavUIBaseViewController.h"
#import "RBNavigationBar.h"
#import <sys/utsname.h>

@interface RBNavUIBaseViewController ()

@end

@implementation RBNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RBWeak(self);
    [self.navigationItem addObserverBlockForKeyPath:RBKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.rb_navgationBar.rb_width = self.view.rb_width;
    [self.view bringSubviewToFront:self.rb_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:RBKeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - DataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(RBNavUIBaseViewController *)navUIBaseViewController {
    return YES;
}

/**头部标题*/
- (NSMutableAttributedString*)rbNavigationBarTitle:(RBNavigationBar *)navigationBar {
    return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景图片 */
//- (UIImage *)rbNavigationBarBackgroundImage:(rbNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)rbNavigationBackgroundColor:(RBNavigationBar *)navigationBar {
    return [UIColor RandomColor];
}

/** 是否显示底部黑线 */
//- (BOOL)rbNavigationIsHideBottomLine:(rbNavigationBar *)navigationBar
//{
//    return NO;
//}

/** 导航条的高度 */
- (CGFloat)rbNavigationHeight:(RBNavigationBar *)navigationBar {
    CGFloat app_statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (!KIsiPhoneX && app_statusBarHeight == 40) {
        app_statusBarHeight = 20;
    }

    return app_statusBarHeight + 44.0;
}


/** 导航条的左边的 view */
//- (UIView *)rbNavigationBarLeftView:(rbNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)rbNavigationBarRightView:(rbNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)rbNavigationBarTitleView:(rbNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(rbNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(rbNavigationBar *)navigationBar
//{
//
//}



#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(RBNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];

    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];

    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];

    return title;
}


- (RBNavigationBar *)rb_navgationBar {
    // 父类控制器必须是导航控制器
    if(!_rb_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        RBNavigationBar *navigationBar = [[RBNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _rb_navgationBar = navigationBar;

        navigationBar.dataSource = self;
        navigationBar.rbDelegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }
    return _rb_navgationBar;
}




- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.rb_navgationBar.title = [self changeTitle:title];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
