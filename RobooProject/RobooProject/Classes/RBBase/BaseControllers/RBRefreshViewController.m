//
//  RBRefreshViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBRefreshViewController.h"

@interface RBRefreshViewController ()

@end

@implementation RBRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RBWeak(self);
    self.tableView.mj_header = [RBNormalRefreshHeader headerWithRefreshingBlock:^{

        [weakself loadIsMore:NO];
    }];
    self.tableView.mj_footer = [RBAutoRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadIsMore:YES];
    }];
    [self.tableView.mj_header beginRefreshing];
}


// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
    }else
    {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
    }
    [self loadMore:isMore];
}


// 结束刷新
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
}

// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    //        NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
