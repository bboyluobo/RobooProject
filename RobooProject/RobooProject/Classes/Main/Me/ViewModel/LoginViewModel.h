//
//  LoginViewModel.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/23.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString * iconUrl ;

@property (nonatomic, copy) NSString * account ;

@property (nonatomic, copy) NSString * password ;

@property (nonatomic, strong) RACSignal * loginEnableSignal ;

@property (nonatomic, strong) RACSubject * statusSubject ;

@property (nonatomic, strong) RACCommand * loginCommand ;

@property (nonatomic, assign) BOOL logoining ;

@end
