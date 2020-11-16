//
//  RBWKWebViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/25.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface RBWKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * mineWKWebView;
//进度条
@property (nonatomic, strong) CALayer * progressLayer;

@property (nonatomic, strong) WKScriptMessage *ocjsHelper;
@end

@implementation RBWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mineWKWebView.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:self.mineWKWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- WKNavigationDelegate

/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLogFunc;
}
/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLogFunc;
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLogFunc;
}
/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLogFunc;
}
/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    DLog(@"URL:%@",scheme);
    NSLogFunc;
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{

}


#pragma mark -- WKWebViewObserver

- (void)observeWKWebKeyPath {
    [RACObserve(self.mineWKWebView, title) subscribeNext:^(id  _Nullable x) {
        self.title = x;
    }];
    [RACObserve(self.mineWKWebView, estimatedProgress) subscribeNext:^(id  _Nullable x) {
        self.progressLayer.opacity = 1;
        DLog(@"X:---->%@",x);
        self.progressLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*[x floatValue], 3);
        if ([x floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }];
}

- (WKWebView *)mineWKWebView {
    if (!_mineWKWebView) {
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        config.allowsAirPlayForMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;

        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        [wkUController addScriptMessageHandler:(id)self.ocjsHelper name:@""];
        config.userContentController = wkUController;
        _mineWKWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCREEN_WIDTH, SCREEN_HRIGHT-Height_NavBar) configuration:config];
        NSString *url = @"https://www.baidu.com";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_mineWKWebView loadRequest:request];
        _mineWKWebView.navigationDelegate = self;
        _mineWKWebView.UIDelegate = self;
        [self observeWKWebKeyPath];
    }
    return _mineWKWebView;
}

- (CALayer *)progressLayer {
    if (!_progressLayer) {
        UIView *progress = [[UIView alloc]init];
        progress.frame = CGRectMake(0, _mineWKWebView.origin.y, SCREEN_WIDTH, 3);
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];

        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, 3);
        _progressLayer.backgroundColor = [UIColor redColor].CGColor;
        [progress.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
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
