//
//  AdvertiseView.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/18.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const NotificationContants_Advertise_Key;

@interface AdvertiseView : UIView

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end
