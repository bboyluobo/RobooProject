//
//  RBEasyBlankPageView.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RBEasyBlankPageViewTypeNoData
} RBEasyBlankPageViewType;

@interface RBEasyBlankPageView : UIView
- (void)configWithType:(RBEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;
@end

@interface UIView (RBConfigBlank)
- (void)configBlankPage:(RBEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
