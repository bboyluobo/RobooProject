//
//  RBRefreshCollectionViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBRefreshCollectionViewController.h"

@interface RBRefreshCollectionViewController ()

@end

@implementation RBRefreshCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    RBWeak(self);
    self.collectionView.mj_header = [RBNormalRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadIsMore:NO];
    }];

    self.collectionView.mj_footer = [RBAutoRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadIsMore:YES];
    }];

    [self.collectionView.mj_header beginRefreshing];
}


// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        if ([self.collectionView.mj_header isRefreshing]) {
            [self.collectionView.mj_footer endRefreshing];
            return;
        }
        self.collectionView.mj_header.hidden = YES;
        self.collectionView.mj_footer.hidden = NO;
    }else
    {
        if ([self.collectionView.mj_footer isRefreshing]) {
            [self.collectionView.mj_header endRefreshing];
            return;
        }
        self.collectionView.mj_header.hidden = NO;
        self.collectionView.mj_footer.hidden = YES;
    }
    [self loadMore:isMore];
}

// 结束刷新
- (void)endHeaderFooterRefreshing
{
    // 结束刷新状态
    ![self.collectionView.mj_header isRefreshing] ?: [self.collectionView.mj_header endRefreshing];
    ![self.collectionView.mj_footer isRefreshing] ?: [self.collectionView.mj_footer endRefreshing];
    self.collectionView.mj_header.hidden = NO;
    self.collectionView.mj_footer.hidden = NO;
}


// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    //        NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}


@end
