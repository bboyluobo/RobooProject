//
//  RBEasyBlankPageView.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBEasyBlankPageView.h"

/**
 空白页
 */

@interface RBEasyBlankPageView ()

/** 加载按钮 */
@property (weak, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (weak, nonatomic) YYAnimatedImageView *imageView;
/** 提示 label */
@property (weak, nonatomic) UILabel *tipLabel;
/** 按钮点击 */
@property (nonatomic, copy) void(^reloadBlock)(UIButton *sender);

@end

@implementation RBEasyBlankPageView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.backgroundColor = newSuperview.backgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.left.right.equalTo(self.imageView);
            make.top.mas_offset(frame.size.height * 0.2);
        }];

        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
            make.centerX.offset(0);
        }];

        [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            //            make.width.mas_equalTo(@94);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

- (void)configWithType:(RBEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block
{
    if (hasData) {
        [self removeFromSuperview];
        return;
    }

    self.reloadBtn.hidden = YES;
    self.tipLabel.hidden = YES;
    self.imageView.hidden = YES;
    self.reloadBlock = block;

    if (hasError) {
        [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
        self.tipLabel.text = @"貌似出了点差错";
        self.reloadBtn.hidden = NO;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
    } else {
        if (blankPageType == RBEasyBlankPageViewTypeNoData) {
            [self.imageView setImage:[UIImage imageNamed:@"common_noRecord"]];
            self.tipLabel.text = @"暂无数据";
            self.reloadBtn.hidden = NO;
            self.tipLabel.hidden = NO;
            self.imageView.hidden = NO;
        }
    }
}

- (void)reloadClick:(UIButton *)btn
{
    !self.reloadBlock ?: self.reloadBlock(btn);
}

- (UIButton *)reloadBtn
{
    if(!_reloadBtn)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _reloadBtn = btn;

        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}

- (YYAnimatedImageView *)imageView
{
    if(!_imageView)
    {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
        imageView.autoPlayAnimatedImage = YES;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel)
    {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipLabel = label;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
    }
    return _tipLabel;
}

@end



static void *BlankPageViewKey = &BlankPageViewKey;

@implementation UIView (RBConfigBlank)

- (void)setBlankPageView:(RBEasyBlankPageView *)blankPageView{
    objc_setAssociatedObject(self, BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RBEasyBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, BlankPageViewKey);
}

- (void)configBlankPage:(RBEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[RBEasyBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.rb_width, self.rb_height)];
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        [self.blankPageView configWithType:blankPageType hasData:NO hasError:hasError reloadButtonBlock:block];
    }
}



@end
