//
//  RBNavigationBar.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RBNavigationBar;
// 主要处理导航条
@protocol  RBNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)rbNavigationBarTitle:(RBNavigationBar *)navigationBar;

/** 背景图片 */
- (UIImage *)rbNavigationBarBackgroundImage:(RBNavigationBar *)navigationBar;
/** 背景色 */
- (UIColor *)rbNavigationBackgroundColor:(RBNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)rbNavigationIsHideBottomLine:(RBNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)rbNavigationHeight:(RBNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)rbNavigationBarLeftView:(RBNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)rbNavigationBarRightView:(RBNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)rbNavigationBarTitleView:(RBNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RBNavigationBar *)navigationBar;
@end


@protocol RBNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(RBNavigationBar *)navigationBar;
@end


@interface RBNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** <#digest#> */
@property (weak, nonatomic) UIView *titleView;

/** <#digest#> */
@property (weak, nonatomic) UIView *leftView;

/** <#digest#> */
@property (weak, nonatomic) UIView *rightView;

/** <#digest#> */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** <#digest#> */
@property (weak, nonatomic) id<RBNavigationBarDataSource> dataSource;

/** <#digest#> */
@property (weak, nonatomic) id<RBNavigationBarDelegate> rbDelegate;

/** <#digest#> */
@property (weak, nonatomic) UIImage *backgroundImage;


@end
