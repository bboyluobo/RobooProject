//
//  RBHorizontalFlowLayout.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBHorizontalFlowLayout.h"

#define RBXX(x) floorf(x)
#define RBXS(s) ceilf(s)

static const NSInteger RB_Lines_ = 3;
static const CGFloat RB_XMargin_ = 10;
static const CGFloat RB_YMargin_ = 10;
static const UIEdgeInsets RB_EdgeInsets_ = {10, 10, 10, 10};

@interface RBHorizontalFlowLayout()

/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *rb_AtrbsArray;

/** 每一列的最后的高度 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *rb_LinesWidthArray;

- (NSInteger)lines;

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)yMargin;

- (UIEdgeInsets)edgeInsets;

@end

@implementation RBHorizontalFlowLayout


/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];

    //如果重新刷新就需要移除之前存储的高度
    [self.rb_LinesWidthArray removeAllObjects];

    //复赋值以顶部的高度, 并且根据行数
    for (NSInteger i = 0; i < self.lines; i++) {
        [self.rb_LinesWidthArray addObject:@(self.edgeInsets.left)];
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

    CGFloat h = 1.0 * (self.collectionView.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom - self.yMargin * (self.lines - 1)) / self.lines;

    h = RBXX(h);

    // 宽度由外界决定, 外界必须实现这个方法
    CGFloat w = [self.delegate waterflowLayout:self collectionView:self.collectionView widthForItemAtIndexPath:indexPath itemHeight:h];

    // 拿到最后的高度最小的那一列, 假设第0列最小
    __block NSInteger indexLine = 0;
    __block CGFloat minLineW = [self.rb_LinesWidthArray[indexLine] doubleValue];

    [self.rb_LinesWidthArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat lineW = obj.doubleValue;
        if(minLineW > lineW)
        {
            minLineW = lineW;
            indexLine = idx;
        }
    }];


    CGFloat x = [self xMarginAtIndexPath:indexPath] + minLineW;

    if (minLineW == self.edgeInsets.left) {
        x = self.edgeInsets.left;
    }

    CGFloat y = self.edgeInsets.top + (self.yMargin + h) * indexLine;

    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);

    // 覆盖添加完后那一列;的最新宽度
    self.rb_LinesWidthArray[indexLine] = @(CGRectGetMaxX(atrbs.frame));

    return atrbs;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.rb_AtrbsArray;
}


- (CGSize)collectionViewContentSize
{
    __block CGFloat maxColW = [self.rb_LinesWidthArray[0] doubleValue];

    [self.rb_LinesWidthArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (maxColW < [obj doubleValue]) {
            maxColW = [obj doubleValue];
        }

    }];

    return CGSizeMake(maxColW + self.edgeInsets.right, self.collectionView.frame.size.height);
}


- (NSMutableArray *)rb_AtrbsArray
{
    if(_rb_AtrbsArray == nil)
    {
        _rb_AtrbsArray = [NSMutableArray array];
    }
    return _rb_AtrbsArray;
}

- (NSMutableArray *)rb_LinesWidthArray
{
    if(_rb_LinesWidthArray == nil)
    {
        _rb_LinesWidthArray = [NSMutableArray array];
    }
    return _rb_LinesWidthArray;
}

- (NSInteger)lines
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:linesInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self linesInCollectionView:self.collectionView];
    }
    else
    {
        return RB_Lines_;
    }
}

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:columnsMarginForItemAtIndexPath:)])
    {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView columnsMarginForItemAtIndexPath:indexPath];
    }
    else
    {
        return RB_XMargin_;
    }
}

- (CGFloat)yMargin
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:linesMarginInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self linesMarginInCollectionView:self.collectionView];
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

- (id<RBHorizontalFlowLayoutDelegate>)delegate
{
    return (id<RBHorizontalFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (instancetype)initWithDelegate:(id<RBHorizontalFlowLayoutDelegate>)delegate
{
    if (self = [super init]) {

    }
    return self;
}


+ (instancetype)flowLayoutWithDelegate:(id<RBHorizontalFlowLayoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}


@end
