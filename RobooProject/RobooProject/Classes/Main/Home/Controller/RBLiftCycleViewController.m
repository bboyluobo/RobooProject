//
//  RBLiftCycleViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/7/9.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBLiftCycleViewController.h"

@interface RBLiftCycleViewController ()

@end

@implementation RBLiftCycleViewController

- (void)loadView
{
    [super loadView];

    [self life:__FUNCTION__];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self life:__FUNCTION__];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self life:__FUNCTION__];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    [self life:__FUNCTION__];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self life:__FUNCTION__];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    [self life:__FUNCTION__];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self life:__FUNCTION__];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self life:__FUNCTION__];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self life:__FUNCTION__];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self life:__FUNCTION__];
}



- (void)life:(const char *)func
{
    RBWordItem *item = [RBWordItem itemWithTitle:[NSString stringWithUTF8String:func] subTitle:nil itemOperation:nil];
    item.titleFont = [UIFont systemFontOfSize:12];

    self.addItem(item);

    [self.tableView reloadData];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
