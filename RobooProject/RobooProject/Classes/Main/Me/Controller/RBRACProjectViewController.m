//
//  RBRACDemoViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/23.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBRACProjectViewController.h"
#import "LoginViewModel.h"

@interface RBRACProjectViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UILabel *loginStateLabel;
@property (nonatomic, strong) LoginViewModel * loginVM ;
@end

@implementation RBRACProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"RAC登陆模块";
    [self bindViewModel] ;
}

- (void)bindViewModel {
    @weakify(self) ;
    //信号传递
    RAC(self.loginVM,account) = self.accountTF.rac_textSignal;
    RAC(self.loginVM,password) = self.passwordTF.rac_textSignal;
    RAC(self.loginBt,enabled) = self.loginVM.loginEnableSignal;
    RAC(self.loginStateLabel,text) = self.loginVM.statusSubject;

    [RACObserve(self.loginVM, iconUrl) subscribeNext:^(id  _Nullable x) {
        @strongify(self) ;
        self.userIcon.image = [UIImage imageNamed:x] ;
    }] ;

    //登录按钮能否点击
    [self.loginVM.loginEnableSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        UIColor *backgroundColor = (x.integerValue == 0)?[UIColor lightGrayColor]:[UIColor orangeColor];
        [self.loginBt setBackgroundColor:backgroundColor];
    }];


    //登录请求
    [[self.loginBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //登录事件
        [self.loginVM.loginCommand execute:@"给我登录"];
    }];
}

- (LoginViewModel *)loginVM{
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
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
