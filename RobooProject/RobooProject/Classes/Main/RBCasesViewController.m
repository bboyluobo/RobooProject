//
//  RBCasesViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCasesViewController.h"
#import "RBWKWebViewController.h"

@interface RBCasesViewController ()

@end

@implementation RBCasesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分享";

    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.rb_height;
    self.tableView.contentInset = edgeInsets;

    RBWordArrowItem *item00 = [RBWordArrowItem itemWithTitle:@"WKWebView" subTitle: nil];
    item00.destVc = [RBWKWebViewController class];

    RBItemSection *section0 = [RBItemSection sectionWithItems:@[item00] andHeaderTitle:@"不吃🐰的萝卜" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
