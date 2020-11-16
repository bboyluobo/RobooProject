//
//  RBElementsFlowLayout.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RBElementsFlowLayout;


@protocol RBElementsFlowLayoutDelegate <NSObject>

@required
/**
 *  要求实现
 *
 *  @param waterflowLayout 哪个布局需要代理返回大小
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *
 *  @return 需要代理高度对应的cell的高度
 */
- (CGSize)waterflowLayout:(RBElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(RBElementsFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;

@end

//MARK:流布局
@interface RBElementsFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<RBElementsFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<RBElementsFlowLayoutDelegate>)delegate;



@end
