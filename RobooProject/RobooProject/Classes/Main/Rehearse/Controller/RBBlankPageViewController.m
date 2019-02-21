//
//  RBBlankPageViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/17.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBBlankPageViewController.h"

@interface RBBlankPageViewController ()

/** 数据资源 */
@property (nonatomic, strong) NSArray *dateArray;

@end

@implementation RBBlankPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

- (void)loadMore:(BOOL)isMore
{
    RBWeak(self);

    [self endHeaderFooterRefreshing];

    [self.tableView reloadData];

    [self.tableView configBlankPage:RBEasyBlankPageViewTypeNoData hasData:self.dateArray.count hasError:self.dateArray.count > 0 reloadButtonBlock:^(id sender) {

        [MBProgressHUD showAutoMessage:@"重新加载数据"];

        [weakself.tableView.mj_header beginRefreshing];

    }];
}



#pragma mark 重写BaseViewController设置内容
- (void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);

    RBWeak(self);
    [self.tableView configBlankPage:RBEasyBlankPageViewTypeNoData hasData:self.dateArray.count > 0 hasError:YES reloadButtonBlock:^(id sender) {

        [weakself.tableView.mj_header beginRefreshing];

    }];
}

- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];

    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}
- (void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);

    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RBNavigationBar *)navigationBar
{

    [rightButton setTitle:@"出错效果" forState:UIControlStateNormal];

    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];

    rightButton.backgroundColor = [UIColor RandomColor];

    rightButton.rb_size = CGSizeMake(80, 44);

    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
