//
//  RBExpandHeader.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBExpandHeader : NSObject

#pragma mark - 类方法
/**
 *  生成一个RBExpandHeader实例
 *
 *  @param scrollView 背景scrollView
 *  @param expandView 可以伸展的背景View
 *
 *  @return RBExpandHeader 对象
 */
+ (instancetype)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法
/**
 *
 *
 *  @param scrollView 背景scrollView
 *  @param expandView 可以伸展的背景View
 */
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;

/** 头部视图 */
@property (weak, nonatomic, readonly) UIView *headerView;

@end
