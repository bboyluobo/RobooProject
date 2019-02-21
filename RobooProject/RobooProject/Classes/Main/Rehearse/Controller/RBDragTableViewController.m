//
//  RBDragTableViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/22.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBDragTableViewController.h"

@interface RBDragTableViewController ()<RBVerticalFlowLayoutDelegate>

/** <#digest#> */
@property (nonatomic, strong) UIImageView *drawImageView;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<NSString *> *datas;

/** <#digest#> */
@property (assign, nonatomic) CGPoint beginPoint;

/** <#digest#> */
@property (strong, nonatomic) NSIndexPath *lastChangeIndexPath;

@end

// 可以更改列数
const NSInteger RBDragTableViewControllerCols_ = 3;

@implementation RBDragTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_interactivePopDisabled = YES;

    RBWeak(self);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];

    [self.collectionView addLongPressGestureRecognizer:^(UILongPressGestureRecognizer *recognizer, NSString *gestureId) {

        if (recognizer.state == UIGestureRecognizerStateBegan) {

            // 获取手势的触摸点
            CGPoint curP = [recognizer locationInView:weakself.collectionView];

            // cur indexPath
            NSIndexPath *curIndexPath = [weakself.collectionView indexPathForItemAtPoint:curP];
            if (!curIndexPath) {
                return ;
            }

            UICollectionViewCell *onCell = [weakself.collectionView cellForItemAtIndexPath:curIndexPath];

            if (!onCell) {
                return ;
            }

            // 为移动做准备
            weakself.beginPoint = curP;
            // 记录最后一个 IndexPath
            weakself.lastChangeIndexPath = curIndexPath;

            weakself.drawImageView.transform = CGAffineTransformIdentity;
            weakself.drawImageView.image = [onCell snapshotImage];
            weakself.drawImageView.frame = onCell.frame;

            [UIView animateWithDuration:0.5 animations:^{

                weakself.drawImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                weakself.drawImageView.alpha = 1;
                onCell.alpha = 0;

            } completion:^(BOOL finished) {

                // 在这里控制隐藏
                // 防止手指刚按下就抬起来 有 bug , 注释掉
                // onCell.hidden = YES;
            }];
        }

        if (recognizer.state == UIGestureRecognizerStateChanged) {

            if (!weakself.lastChangeIndexPath) {
                return;
            }
            UICollectionViewCell *lastChangeIndexPathCell = [weakself.collectionView cellForItemAtIndexPath:weakself.lastChangeIndexPath];
            if (!lastChangeIndexPathCell) {
                return;
            }
            // 在这里控制隐藏
            // 防止手指刚按下就抬起来
            lastChangeIndexPathCell.hidden = YES;

            // 移动视图
            // 获取手势的移动，也是相对于最开始的位置
            CGPoint curPoint = [recognizer locationInView:weakself.collectionView];

            CGPoint translation = CGPointMake(curPoint.x - weakself.beginPoint.x, curPoint.y - weakself.beginPoint.y);

            CGAffineTransform scale = CGAffineTransformMakeScale(1.1, 1.1);
            weakself.drawImageView.transform = CGAffineTransformTranslate(scale, translation.x, translation.y);
            [weakself.collectionView bringSubviewToFront:weakself.drawImageView];

            // 获取当前的 indexPath
            NSIndexPath *curIndexPath = [weakself.collectionView indexPathForItemAtPoint:curPoint];

            if (!curIndexPath) {
                return;
            }
            UICollectionViewCell *onCell = [weakself.collectionView cellForItemAtIndexPath:curIndexPath];
            if (!onCell) {
                return;
            }

            // 更换 cell
            if (curIndexPath && (curIndexPath.item != weakself.lastChangeIndexPath.item)) {

                [weakself.datas exchangeObjectAtIndex:curIndexPath.item withObjectAtIndex:weakself.lastChangeIndexPath.item];

                // 把 cell移动到当前位置
                [weakself.collectionView moveItemAtIndexPath:weakself.lastChangeIndexPath toIndexPath:curIndexPath];
                // 记录当前的 indexPath
                weakself.lastChangeIndexPath = curIndexPath;
            }
        }

        if (recognizer.state == UIGestureRecognizerStateEnded) {

            if (!weakself.lastChangeIndexPath) {
                return;
            }

            UICollectionViewCell *beginCell = [weakself.collectionView cellForItemAtIndexPath:weakself.lastChangeIndexPath];
            [weakself.collectionView bringSubviewToFront:beginCell];

            // 从当前的位置移动过去
            CGRect curDragFrame = weakself.drawImageView.frame;

            CGRect targetFrame = beginCell.frame;
            beginCell.frame = curDragFrame;
            weakself.drawImageView.alpha = 0;

            beginCell.alpha = 1;
            beginCell.hidden = NO;

            [UIView animateWithDuration:0.5 animations:^{
                beginCell.frame = targetFrame;
            } completion:^(BOOL finished) {
                weakself.lastChangeIndexPath = nil;
            }];
        }
    }];
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];


    cell.contentView.clipsToBounds = YES;
    if (![cell.contentView viewWithTag:100]) {

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.tag = 100;
        label.textColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:label];
        cell.contentView.backgroundColor = [UIColor RandomColor];
    }

    UILabel *label = [cell.contentView viewWithTag:100];

    label.text = self.datas[indexPath.item];


    return cell;
}




#pragma mark - getter
- (UIImageView *)drawImageView
{
    if(_drawImageView == nil)
    {
        UIImageView *drawImageView = [[UIImageView alloc] init];
        _drawImageView = drawImageView;
        drawImageView.userInteractionEnabled = YES;
        [self.collectionView addSubview:drawImageView];

    }
    return _drawImageView;
}

- (NSMutableArray<NSString *> *)datas
{
    if(_datas == nil)
    {
        _datas = [NSMutableArray array];

        for (NSInteger i = 0; i < 20; i++) {
            [_datas addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    return _datas;
}

#pragma mark - RBCollectionViewControllerDataSource
- (UICollectionViewLayout *)collectionViewController:(RBCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView
{

    RBVerticalFlowLayout *myLayout = [[RBVerticalFlowLayout alloc] initWithDelegate:self];

    return myLayout;
}


#pragma mark - RBVerticalFlowLayoutDelegate

- (CGFloat)waterflowLayout:(RBVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return 100;
}
/**
 *  需要显示的列数, 默认3
 */
- (NSInteger)waterflowLayout:(RBVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView
{
    return RBDragTableViewControllerCols_;
}
/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBVerticalFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(RBVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return 10;
}

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(RBVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

#pragma mark - RBNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];

    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - RBNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
