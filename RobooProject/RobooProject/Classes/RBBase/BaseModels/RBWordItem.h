//
//  RBWordItem.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBWordItem : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 副标题的字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 主标题的颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** subTitle */
@property (nonatomic, copy) NSString *subTitle;
/** 副标题的字体 */
@property (nonatomic, strong) UIFont *subTitleFont;
/** 副标题的颜色 */
@property (nonatomic, strong) UIColor *subTitleColor;
/** 副标题行数限制 */
@property (nonatomic, assign)  NSInteger subTitleNumberOfLines;

/** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
@property (nonatomic, strong) id image;

/** 设置cell的高度, 默认50 */
@property (assign, nonatomic) CGFloat cellHeight;


/** 是否自定义这个cell , 如果自定义, 则在tableview返回默认的cell, 自己需要自定义cell返回*/
@property (assign, nonatomic, getter=isNeedCustom) BOOL needCustom;

/** 点击操作 */
@property (nonatomic, copy) void(^itemOperation)(NSIndexPath *indexPath);

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;


@end
