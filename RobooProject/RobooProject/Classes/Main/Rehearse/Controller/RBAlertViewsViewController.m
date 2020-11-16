//
//  RBAlertViewsViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/31.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBAlertViewsViewController.h"
#import "JXTAlertController.h"

@interface RBAlertViewsViewController ()

@end

@implementation RBAlertViewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    RBWordItem *item0 = [RBWordItem itemWithTitle:@"常规 Alertcontroller-alert" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [UIAlertController rb_showAlertWithTitle:@"常规alertController-Alert" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }
            else if (buttonIndex == 1) {
                NSLog(@"按钮1");
            }
            NSLog(@"%@--%@", action.title, action);
        }];
    }] ;

    RBWordItem *item1 = [RBWordItem itemWithTitle:@"常规alertController-ActionSheet" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self jxt_showActionSheetWithTitle:@"常规alertController-ActionSheet" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1").
            addActionDefaultTitle(@"按钮2").
            addActionDefaultTitle(@"按钮3").
            addActionDestructiveTitle(@"按钮4");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {

            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"按钮1"]) {
                NSLog(@"按钮1");
            }
            else if ([action.title isEqualToString:@"按钮2"]) {
                NSLog(@"按钮2");
            }
            else if ([action.title isEqualToString:@"按钮3"]) {
                NSLog(@"按钮3");
            }
            else if ([action.title isEqualToString:@"按钮4"]) {
                NSLog(@"按钮4");
            }
        }];
    }] ;

    RBWordItem *item2 = [RBWordItem itemWithTitle:@"无按钮alert-toast" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self jxt_showAlertWithTitle:@"无按钮alert-toast" message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
            [alertMaker setAlertDidShown:^{
                //                [self logMsg:@"alertDidShown"];//不用担心循环引用
            }];
            alertMaker.alertDidDismiss = ^{
                //                [self logMsg:@"alertDidDismiss"];
            };
        } actionsBlock:NULL];
    }] ;

    RBWordItem *item3 = [RBWordItem itemWithTitle:@"无按钮actionSheet-toast" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [UIAlertController rb_showActionSheetWithTitle:@"无按钮actionSheet-toast" message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 3;
            //关闭动画效果
            //            [alertMaker alertAnimateDisabled];

            [alertMaker setAlertDidShown:^{
                NSLog(@"alertDidShown");
            }];
            alertMaker.alertDidDismiss = ^{
                NSLog(@"alertDidDismiss");
            };
        } actionsBlock:NULL];
    }] ;

    RBWordItem *item4 = [RBWordItem itemWithTitle:@"带输入框的alertController-Alert" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self jxt_showAlertWithTitle:@"带输入框的alertController-Alert" message:@"点击按钮，控制台打印对应输入框的内容" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionDestructiveTitle(@"获取输入框1").
            addActionDestructiveTitle(@"获取输入框2");

            [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"输入框1-请输入";
            }];
            [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"输入框2-请输入";
            }];
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                UITextField *firsttextField = alertSelf.textFields.firstObject;
                UITextField *lasttextField = alertSelf.textFields.lastObject;
                //                [self logMsg:textField.text];//不用担心循环引用
                NSLog(@"%@+%@", firsttextField.text,lasttextField.text);
            }
            else if (buttonIndex == 1) {
                UITextField *textField = alertSelf.textFields.lastObject;
                //                [self logMsg:textField.text];
                NSLog(@"%@", textField.text);
            }
        }];
    }] ;


    RBItemSection * itemSection = [RBItemSection sectionWithItems:@[item0,item1,item2,item3,item4] andHeaderTitle:nil footerTitle:nil] ;
    [self.sections addObject:itemSection] ;
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
