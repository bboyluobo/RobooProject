//
//  RBPrivateSystemViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/17.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBPrivateSystemViewController.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>

@interface RBPrivateSystemViewController ()

@end

@implementation RBPrivateSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 传入类获取该类的私有属性
    [self getAllProperty:[MPVolumeView class]];
    // 传入类获取该类的私有方法
    [self getAllFunction:[MPVolumeView class]];
}

// 私有属性获取
- (void)getAllProperty:(Class)class {
    // 定义变量
    unsigned int count;
    // 运行时获取私有属性列表
    objc_property_t *properties = class_copyPropertyList(class, &count);

    for (int index = 0; index < count; ++index) {
        // 声明属性
        objc_property_t property = properties[index];

        // 指针数组. 通过property_getName获取属性的名称
        const char *cName = property_getName(property);
        // UTF8转码
        NSString *name = [NSString stringWithUTF8String:cName];
        [self showTitle:[NSString stringWithFormat:@"name -----> %@", name]];
    }
}

// 私有方法获取
- (void)getAllFunction:(Class)class {
    // 定义变量
    unsigned int count;
    // 运行时获取私有方法列表
    Method *methods = class_copyMethodList(class, &count);

    for (int index = 0; index < count; ++index) {
        Method method = methods[index];

        // 这步完了之后, 可以获取到方法的地址
        SEL selector = method_getName(method);

        NSString *name = NSStringFromSelector(selector);
        // 确定方法类型
        const char *type = method_getTypeEncoding(method);
        [self showTitle:[NSString stringWithFormat:@"fun-----%@,  type-----> %s",name,type]];
    }
}

- (void)showTitle:(NSString *)func
{
    RBWordItem *item = [RBWordItem itemWithTitle:func subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self jxt_showAlertWithTitle:@"MediaPlayer系统库" message:func appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 3;
            [alertMaker setAlertDidShown:^{
                NSLog(@"alertDidShown");
            }];
            alertMaker.alertDidDismiss = ^{
                NSLog(@"alertDidDismiss");
            };
        } actionsBlock:NULL];
    }];
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

@end
