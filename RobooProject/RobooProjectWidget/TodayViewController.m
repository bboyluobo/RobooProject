//
//  TodayViewController.m
//  RobooProjectWidget
//
//  Created by 物联网美天科技 on 2020/11/10.
//  Copyright © 2020 物联网美天科技. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 60, 40)];
    [btn setTitle:@"Enter" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)click:(UIButton *)btn {
    NSString *schemeString = [NSString stringWithFormat:@"RobooProjectWidget://url=Main"];
    [self.extensionContext openURL:[NSURL URLWithString:schemeString] completionHandler:^(BOOL success) {
        
    }];
}


- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 105);
    } else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 500);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
