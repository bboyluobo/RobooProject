//
//  AdvertiseHelper.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/18.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseView.h"

@interface AdvertiseHelper : NSObject
+ (instancetype)sharedInstance;

+ (void)showAdvertiserView:(NSArray<NSString *> *)imageArray;
@end
