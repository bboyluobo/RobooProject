//
//  RBItemSection.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RBWordItem;
@interface RBItemSection : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<RBWordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<RBWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;


@end
