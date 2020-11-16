//
//  RBAutoRefreshFooter.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBAutoRefreshFooter.h"

@implementation RBAutoRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce
{
    self.automaticallyChangeAlpha = YES;
}

// MJBug fix
- (void)endRefreshing {
    [super endRefreshing];
    self.state = MJRefreshStateIdle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
