//
//  RBBlockLoopViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/7/9.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBBlockLoopViewController.h"
#import "RBChildBlockViewController.h"
#import "RBModalBlockViewController.h"
#import "RBBlockLoopOperation.h"

@interface RBBlockLoopViewController ()

@property (nonatomic, strong) UIButton *myButton, *myBlockButton,*myModelButtton;

@property (nonatomic, strong) UIView * myBlockView;

@property (nonatomic, strong) RBBlockLoopOperation *operation;
@end

@implementation RBBlockLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RBWeak(self) ;
    _myBlockView = [[UIView alloc]init];
    _myBlockView.height = 120;
    _myBlockView.backgroundColor = [UIColor RandomColor];
    self.tableView.tableHeaderView = _myBlockView;
    [_myBlockView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weakself.view makeToast:@"点击了"];
    }] ;
    self.addItem([RBWordArrowItem itemWithTitle:@"跳转子页面" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself myButtonAction];
    }])
    .addItem([RBWordArrowItem itemWithTitle:@"弹出模态窗口" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself myModelButttonAction];
    }])
    .addItem ([RBWordItem itemWithTitle:@"响应BlockLoopOperation中的block" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself myBlockButtonAction];
    }]) ;
}


-(void)myButtonAction{
    RBWeak(self);
    RBChildBlockViewController *VC = [[RBChildBlockViewController alloc]init];
    VC.successBlock = ^{
        [weakself loadPage];
    } ;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)myModelButttonAction{
    RBModalBlockViewController *VC = [[RBModalBlockViewController alloc]init];
    RBWeak(VC);
    VC.successBlock = ^{
        if (weakVC ) {
            [weakVC dismissViewControllerAnimated:YES completion:nil];
        }
    };
    //    A presentViewController B 后，a.presentedViewController就是b，b.presentingViewController就是a，
    [self presentViewController:VC animated:YES completion:nil];
}


-(void)myBlockButtonAction{
    RBWeak(self);
    [RBBlockLoopOperation operateWithSuccessBlock:^{
        [self.view makeToast:@"成功执行了"];
    }];
    RBBlockLoopOperation *operation = [[RBBlockLoopOperation alloc]init];
    _operation = operation;
    operation.address = @"不吃兔子的萝卜";
    RBWeak(operation);
    operation.logAddress = ^(NSString *address) {
        [weakself showErrorMessage:weakoperation.address];
    };
}


-(void)showErrorMessage:(NSString *)message
{
    NSLog(@"当前信息,%@",message);
}

-(void)loadPage
{
    NSLog(@"刷新当前的数据源");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
