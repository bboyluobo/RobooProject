//
//  RBExpandImageView.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBExpandImageView.h"

@implementation RBExpandImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupOnce];
    }

    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupOnce];
}

- (void)setupOnce
{
    //关键步骤 设置可变化背景view属性
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;

    self.userInteractionEnabled = YES;
}

@end
