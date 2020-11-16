//
//  RBBlockLoopOperation.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/7/10.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBBlockLoopOperation : NSObject

+ (void)operateWithSuccessBlock:(void(^)())successBlock;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) void(^logAddress)(NSString *address);

@end
