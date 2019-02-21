//
//  RBVerticalFlowLayout.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBVerticalFlowLayout.h"
#define RBXX(x) floorf(x)
#define RBXS(s) ceilf(s)

static const NSInteger RB_Columns_ = 3;
static const CGFloat RB_XMargin_ = 10;
static const CGFloat RB_YMargin_ = 10;
static const UIEdgeInsets RB_EdgeInsets_ = {20, 10, 10, 10};

@interface RBVerticalFlowLayout()

/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *rb_AtrbsArray;

/** 每一列的最后的高度 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *rb_ColumnsHeightArray;

- (NSInteger)columns;

- (CGFloat)xMargin;

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)edgeInsets;

@end


@implementation RBVerticalFlowLayout


/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];

    //如果重新刷新就需要移除之前存储的高度
    [self.rb_ColumnsHeightArray removeAllObjects];

    //复赋值以顶部的高度, 并且根据列数
    for (NSInteger i = 0; i < self.columns; i++) {
        [self.rb_ColumnsHeightArray addObject:@(self.edgeInsets.top)];
    }

    // 移除以前计算的cells的attrbs
    [self.rb_AtrbsArray removeAllObjects];

    // 并且重新计算, 每个cell对应的atrbs, 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
        [self.rb_AtrbsArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }

}


/**
 *在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGFloat w = 1.0 * (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.xMargin * (self.columns - 1)) / self.columns;

    w = RBXX(w);

    // 高度由外界决定, 外界必须实现这个方法
    CGFloat h = [self.delegate waterflowLayout:self collectionView:self.collectionView heightForItemAtIndexPath:indexPath itemWidth:w];

    // 拿到最后的高度最小的那一列, 假设第0列最小
    __block NSInteger indexCol = 0;
    __block CGFloat minColH = [self.rb_ColumnsHeightArray[indexCol] doubleValue];

    [self.rb_ColumnsHeightArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat colH = obj.floatValue;
        if (minColH > colH) {
            minColH = colH;
            indexCol = idx;
        }
    }];

    CGFloat x = self.edgeInsets.left + (self.xMargin + w) * indexCol;

    CGFloat y = minColH + [self yMarginAtIndexPath:indexPath];

    // 是第一行
    if (minColH == self.edgeInsets.top) {
        y = self.edgeInsets.top;
    }

    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);

    // 覆盖添加完后那一列;的最新高度
    self.rb_ColumnsHeightArray[indexCol] = @(CGRectGetMaxY(atrbs.frame));

    return atrbs;
}

// layoutAttributesForElementsInRect
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.rb_AtrbsArray;
}


- (CGSize)collectionViewContentSize
{
    CGFloat maxColH = [self.rb_ColumnsHeightArray.firstObject doubleValue];

    for (NSInteger i = 1; i < self.rb_ColumnsHeightArray.count; i++)
    {
        CGFloat colH = [self.rb_ColumnsHeightArray[i] doubleValue];
        if(maxColH < colH)
        {
            maxColH = colH;
        }
    }

    return CGSizeMake(self.collectionView.frame.size.width, maxColH + self.edgeInsets.bottom);
}


- (NSMutableArray *)rb_AtrbsArray
{
    if(_rb_AtrbsArray == nil)
    {
        _rb_AtrbsArray = [NSMutableArray array];
    }
    return _rb_AtrbsArray;
}

- (NSMutableArray *)rb_ColumnsHeightArray
{
    if(_rb_ColumnsHeightArray == nil)
    {
        _rb_ColumnsHeightArray = [NSMutableArray array];
    }
    return _rb_ColumnsHeightArray;
}

- (NSInteger)columns
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:columnsInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self columnsInCollectionView:self.collectionView];
    }
    else
    {
        return RB_Columns_;
    }
}

- (CGFloat)xMargin
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:columnsMarginInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self columnsMarginInCollectionView:self.collectionView];
    }
    else
    {
        return RB_XMargin_;
    }
}

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:linesMarginForItemAtIndexPath:)])
    {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    }else
    {
        return RB_YMargin_;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:edgeInsetsInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self edgeInsetsInCollectionView:self.collectionView];
    }
    else
    {
        return RB_EdgeInsets_;
    }
}

- (id<RBVerticalFlowLayoutDelegate>)delegate
{
    return (id<RBVerticalFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (instancetype)initWithDelegate:(id<RBVerticalFlowLayoutDelegate>)delegate
{
    if (self = [super init]) {
    }
    return self;
}


+ (instancetype)flowLayoutWithDelegate:(id<RBVerticalFlowLayoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}


@end
