//
//  RBHomeViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBHomeViewController.h"
#import "RBLiftCycleViewController.h"
#import "RBBlockLoopViewController.h"
#import "RBCoreAnimationViewController.h"
#import "RBPrivateSystemViewController.h"

@interface RBHomeViewController ()

@end

@implementation RBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"基础";
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.rb_height;
    self.tableView.contentInset = edgeInsets;

    RBWordArrowItem *item00 = [RBWordArrowItem itemWithTitle:@"ViewController的生命周期" subTitle: nil];
    item00.destVc = [RBLiftCycleViewController class];

    RBWordArrowItem *item01 = [RBWordArrowItem itemWithTitle:@"Block 内存释放" subTitle: nil];
    item01.destVc = [RBBlockLoopViewController class];

    RBWordArrowItem *item02 = [RBWordArrowItem itemWithTitle:@"私有属性、私有方法获取" subTitle: nil];
    item02.destVc = [RBPrivateSystemViewController class];

    //MARK:动画

    RBWordArrowItem * item10 = [RBWordArrowItem itemWithTitle:@"核心动画 CoreAnimation" subTitle:@"CATransform3D"];
    item10.destVc = [RBCoreAnimationViewController class];



    RBItemSection *section0 = [RBItemSection sectionWithItems:@[item00, item01, item02] andHeaderTitle:@"生命周期, block, API私有方法和属性" footerTitle:nil];

    RBItemSection *section1 = [RBItemSection sectionWithItems:@[item10] andHeaderTitle:@"核心动画" footerTitle:nil];

    [self.sections addObjectsFromArray:@[section0,section1]];

    UITabBarItem *homeItem = self.navigationController.tabBarItem;
    [homeItem setBadgeValue:@"3"];
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
