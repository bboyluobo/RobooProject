//
//  RBPDFViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/27.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBPDFViewController.h"

@interface RBPDFViewController ()

@property (nonatomic,strong) UIWebView * myWebView;

@end

@implementation RBPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _myWebView.backgroundColor = [UIColor whiteColor];
    NSURL *filePath = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"82535116" ofType:@"pdf"]];
    NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
    [_myWebView loadRequest:request];
    //使文档的显示范围适合UIWebView的bounds
    [_myWebView setScalesPageToFit:YES];
    [self.view addSubview:_myWebView] ;
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持横竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    if (size.width > size.height) { // 横屏
        _myWebView.frame = CGRectMake(0, Height_NavBar, size.width, size.height-Height_NavBar);
        // 横屏布局 balabala
    } else {
        // 竖屏布局 balabala
        _myWebView.frame = CGRectMake(0, Height_NavBar, SCREEN_WIDTH, SCREEN_HRIGHT-Height_NavBar);
    }
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
