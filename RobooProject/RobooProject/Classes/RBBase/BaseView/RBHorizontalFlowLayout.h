//
//  RBHorizontalFlowLayout.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RBHorizontalFlowLayout;


@protocol RBHorizontalFlowLayoutDelegate <NSObject>

@required
/**
 *  要求实现
 *
 *  @param waterflowLayout 哪个布局需要代理返回高度
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *  @param itemHeight           layout内部计算的高度
 *
 *  @return 需要代理高度对应的cell的宽度
 */
- (CGFloat)waterflowLayout:(RBHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight;
@optional

/**
 *  需要显示的行数, 默认3
 */
- (NSInteger)waterflowLayout:(RBHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView;

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBHorizontalFlowLayout *)waterflowLayout linesMarginInCollectionView:(UICollectionView *)collectionView;

/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(RBHorizontalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end


@interface RBHorizontalFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<RBHorizontalFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<RBHorizontalFlowLayoutDelegate>)delegate;

@end
