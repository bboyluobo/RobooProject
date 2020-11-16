//
//  RBTableViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBBaseViewController.h"

@interface RBTableViewController : RBBaseViewController<UITableViewDelegate, UITableViewDataSource>

// 这个代理方法如果子类实现了, 必须调用super
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

/** <#digest#> */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// tableview的样式, 默认plain
- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
