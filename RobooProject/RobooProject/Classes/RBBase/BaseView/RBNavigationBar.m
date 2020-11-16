//
//  RBNavigationBar.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBNavigationBar.h"

#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation RBNavigationBar

#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupRBNavigationBarUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupRBNavigationBarUIOnce];
}



- (void)layoutSubviews
{
    CGFloat app_statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (!KIsiPhoneX && app_statusBarHeight == 40) {
        app_statusBarHeight = 20;
    }
    [super layoutSubviews];

    [self.superview bringSubviewToFront:self];

    self.leftView.frame = CGRectMake(0, app_statusBarHeight, self.leftView.rb_width, self.leftView.rb_height);

    self.rightView.frame = CGRectMake(self.rb_width - self.rightView.rb_width, app_statusBarHeight, self.rightView.rb_width, self.rightView.rb_height);

    self.titleView.frame = CGRectMake(0, app_statusBarHeight + (44.0 - self.titleView.rb_height) * 0.5, MIN(self.rb_width - MAX(self.leftView.rb_width, self.rightView.rb_width) * 2 - kViewMargin * 2, self.titleView.rb_width), self.titleView.rb_height);

    self.titleView.rb_x = (self.rb_width * 0.5 - self.titleView.rb_width * 0.5);

    self.bottomBlackLineView.frame = CGRectMake(0, self.rb_height, self.rb_width, 0.5);

}



#pragma mark - Setter
- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];

    _titleView = titleView;

    __block BOOL isHaveTapGes = NO;

    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {

            isHaveTapGes = YES;

            *stop = YES;
        }
    }];

    if (!isHaveTapGes) {

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];

        [titleView addGestureRecognizer:tap];
    }


    [self layoutIfNeeded];
}




- (void)setTitle:(NSMutableAttributedString *)title
{
    // bug fix
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBarTitleView:)] && [self.dataSource rbNavigationBarTitleView:self]) {
        return;
    }

    /**头部标题*/
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.rb_width * 0.4, 44)];

    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.lineBreakMode = NSLineBreakByClipping;

    self.titleView = navTitleLabel;
}


- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];

    [self addSubview:leftView];

    _leftView = leftView;


    if ([leftView isKindOfClass:[UIButton class]]) {

        UIButton *btn = (UIButton *)leftView;

        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    [self layoutIfNeeded];

}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;

    self.layer.contents = (id)backgroundImage.CGImage;
}



- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];

    [self addSubview:rightView];

    _rightView = rightView;

    if ([rightView isKindOfClass:[UIButton class]]) {

        UIButton *btn = (UIButton *)rightView;

        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    [self layoutIfNeeded];
}



- (void)setDataSource:(id<RBNavigationBarDataSource>)dataSource
{
    _dataSource = dataSource;

    [self setupDataSourceUI];
}


#pragma mark - getter

- (UIView *)bottomBlackLineView
{
    if(!_bottomBlackLineView)
    {
        CGFloat height = 0.5;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn
{
    if ([self.rbDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {

        [self.rbDelegate leftButtonEvent:btn navigationBar:self];

    }

}


- (void)rightBtnClick:(UIButton *)btn
{
    if ([self.rbDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {

        [self.rbDelegate rightButtonEvent:btn navigationBar:self];

    }

}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    UILabel *view = (UILabel *)Tap.view;
    if ([self.rbDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {

        [self.rbDelegate titleClickEvent:view navigationBar:self];

    }
}



#pragma mark - custom

- (void)setupDataSourceUI
{

    /** 导航条的高度 */

    if ([self.dataSource respondsToSelector:@selector(rbNavigationHeight:)]) {

        self.rb_size = CGSizeMake(kScreenWidth, [self.dataSource rbNavigationHeight:self]);

    }else
    {
        self.rb_size = CGSizeMake(kScreenWidth, kDefaultNavBarHeight);
    }

    /** 是否显示底部黑线 */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationIsHideBottomLine:)]) {

        if ([self.dataSource rbNavigationIsHideBottomLine:self]) {
            self.bottomBlackLineView.hidden = YES;
        }

    }

    /** 背景图片 */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBarBackgroundImage:)]) {

        self.backgroundImage = [self.dataSource rbNavigationBarBackgroundImage:self];
    }

    /** 背景色 */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBackgroundColor:)]) {
        self.backgroundColor = [self.dataSource rbNavigationBackgroundColor:self];
    }


    /** 导航条中间的 View */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBarTitleView:)]) {

        self.titleView = [self.dataSource rbNavigationBarTitleView:self];

    }else if ([self.dataSource respondsToSelector:@selector(rbNavigationBarTitle:)])
    {
        /**头部标题*/
        self.title = [self.dataSource rbNavigationBarTitle:self];
    }


    /** 导航条的左边的 view */
    /** 导航条左边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBarLeftView:)]) {

        self.leftView = [self.dataSource rbNavigationBarLeftView:self];

    }else if ([self.dataSource respondsToSelector:@selector(rbNavigationBarLeftButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];

        btn.titleLabel.font = [UIFont systemFontOfSize:16];

        UIImage *image = [self.dataSource rbNavigationBarLeftButtonImage:btn navigationBar:self];

        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }

        self.leftView = btn;
    }

    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(rbNavigationBarRightView:)]) {

        self.rightView = [self.dataSource rbNavigationBarRightView:self];

    }else if ([self.dataSource respondsToSelector:@selector(rbNavigationBarRightButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];

        btn.titleLabel.font = [UIFont systemFontOfSize:16];

        UIImage *image = [self.dataSource rbNavigationBarRightButtonImage:btn navigationBar:self];

        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }

        self.rightView = btn;
    }

}


- (void)setupRBNavigationBarUIOnce
{
    self.backgroundColor = [UIColor whiteColor];
}


@end
