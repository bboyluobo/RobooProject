//
//  RBRefreshCollectionViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCollectionViewController.h"
#import "RBAutoRefreshFooter.h"
#import "RBNormalRefreshHeader.h"

@interface RBRefreshCollectionViewController : RBCollectionViewController

- (void)loadMore:(BOOL)isMore;

// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;


@end
