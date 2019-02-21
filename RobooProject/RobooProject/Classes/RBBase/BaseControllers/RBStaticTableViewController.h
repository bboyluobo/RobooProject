//
//  RBStaticTableViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTableViewController.h"
#import "RBItemSection.h"
#import "RBWordItem.h"
#import "RBWordArrowItem.h"

@interface RBStaticTableViewController : RBTableViewController

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray<RBItemSection *> *sections;


// 自定义某一行cell的时候调用super, 返回为空
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (RBStaticTableViewController *(^)(RBWordItem *item))addItem;

@end

UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;
