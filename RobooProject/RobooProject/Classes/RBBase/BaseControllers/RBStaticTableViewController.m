//
//  RBStaticTableViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBStaticTableViewController.h"
#import "RBSettingCell.h"

const UIEdgeInsets tableViewDefaultSeparatorInset = {0, 15, 0, 0};
const UIEdgeInsets tableViewDefaultLayoutMargins = {8, 8, 8, 8};

@interface RBStaticTableViewController ()


@end

@implementation RBStaticTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"self.tableView.separatorInset = %@, self.tableView.separatorInset = %@", NSStringFromUIEdgeInsets(self.tableView.separatorInset), NSStringFromUIEdgeInsets(self.tableView.layoutMargins));
    //    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.layoutMargins = UIEdgeInsetsZero;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RBWordItem *item = self.sections[indexPath.section].items[indexPath.row];


    RBSettingCell *cell = [RBSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];

    cell.item = item;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    RBWordItem *item = self.sections[indexPath.section].items[indexPath.row];

    // 普通的cell
    if(item.itemOperation)
    {
        item.itemOperation(indexPath);
        return;
    }

    // 带箭头的cell
    if([item isKindOfClass:[RBWordArrowItem class]])
    {
        RBWordArrowItem *arrowItem = (RBWordArrowItem *)item;

        if(arrowItem.destVc)
        {
            UIViewController *vc = [[arrowItem.destVc alloc] init];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.navigationItem.title = arrowItem.title;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }


}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sections[section].footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

- (NSMutableArray<RBItemSection *> *)sections
{
    if(_sections == nil)
    {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (RBStaticTableViewController *(^)(RBWordItem *))addItem {

    RBWeak(self);
    if (!self.sections.firstObject) {
        [self.sections addObject:[RBItemSection sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
    }
    return  ^(RBWordItem *item) {
        [weakself.sections.firstObject.items addObject:item];
        return weakself;
    };
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
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
