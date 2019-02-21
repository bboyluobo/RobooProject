//
//  RBRefreshViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTableViewController.h"
#import "RBAutoRefreshFooter.h"
#import "RBNormalRefreshHeader.h"

@interface RBRefreshViewController : RBTableViewController

- (void)loadMore:(BOOL)isMore;


// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;


@end
