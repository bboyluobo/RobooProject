//
//  RBRehearseViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBRehearseViewController.h"
#import "RBBlankPageViewController.h"
#import "RBRACUsageViewController.h"
#import "RBNavBarFadeViewController.h"
#import "RBDragTableViewController.h"
#import "RBAlertViewsViewController.h"
#import "RBAdaptFontViewController.h"
#import "RBPDFViewController.h"

@interface RBRehearseViewController ()

@end

@implementation RBRehearseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadRehearseData];
}

- (void)loadRehearseData{
    RBWordArrowItem * blankPageItem = [RBWordArrowItem itemWithTitle:@"空白页展示" subTitle:@"Error Blank"] ;
    blankPageItem.destVc = [RBBlankPageViewController class] ;

    RBWordArrowItem * RACUsageItem = [RBWordArrowItem itemWithTitle:@"RAC常用" subTitle:@"RAC Usage"] ;
    RACUsageItem.destVc = [RBRACUsageViewController class] ;

    RBWordArrowItem * navBarFadeItem = [RBWordArrowItem itemWithTitle:@"导航条渐变" subTitle:@""] ;
    navBarFadeItem.destVc = [RBNavBarFadeViewController class];

    RBWordArrowItem * dragTableItem = [RBWordArrowItem itemWithTitle:@"列表拖拽" subTitle:@""] ;
    dragTableItem.destVc = [RBDragTableViewController class] ;

    RBWordArrowItem * alertViewsItem = [RBWordArrowItem itemWithTitle:@"自定义各种弹框" subTitle:@""] ;
    alertViewsItem.destVc = [RBAlertViewsViewController class] ;

    RBWordArrowItem * adaptFontItem = [RBWordArrowItem itemWithTitle:@"字体适配屏幕" subTitle:@"FontSize适配"] ;
    adaptFontItem.destVc = [RBAdaptFontViewController class] ;

    RBWordArrowItem * pdfFontItem = [RBWordArrowItem itemWithTitle:@"PDF查看" subTitle:@"PDF"] ;
    pdfFontItem.destVc = [RBPDFViewController class] ;

    RBItemSection * rehearseSection = [RBItemSection sectionWithItems:@[blankPageItem,RACUsageItem,navBarFadeItem,dragTableItem,alertViewsItem,adaptFontItem,pdfFontItem] andHeaderTitle:@"静态单元格头部标题" footerTitle:@"静态单元格尾部标题"] ;



    [self.sections addObject:rehearseSection] ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写BaseViewController设置内容

- (UIColor *)rbNavigationBackgroundColor:(RBNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}
- (BOOL)rbNavigationIsHideBottomLine:(RBNavigationBar *)navigationBar
{
    return NO;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)rbNavigationBarTitle:(RBNavigationBar *)navigationBar
{
    return [self changeTitle:@"自定义导航栏 View"];
}


- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setTitle:@"左边" forState: UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    return nil;
}


- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RBNavigationBar *)navigationBar
{
    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setTitle:@"右边" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    return nil;
}



#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];

    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];

    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];

    return title;
}


@end
