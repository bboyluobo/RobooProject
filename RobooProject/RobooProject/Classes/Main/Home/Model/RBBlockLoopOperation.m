//
//  RBBlockLoopOperation.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/7/10.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBBlockLoopOperation.h"

@implementation RBBlockLoopOperation

+ (void)operateWithSuccessBlock:(void(^)())successBlock
{
    if (successBlock) {
        successBlock();
    }
}

- (void)setLogAddress:(void (^)(NSString *address))logAddress {
    _logAddress = logAddress;

    !_logAddress ?: _logAddress(self.address);
}

- (void)dealloc {
    NSLog(@"dealloc- %@", self.class);
}

@end
