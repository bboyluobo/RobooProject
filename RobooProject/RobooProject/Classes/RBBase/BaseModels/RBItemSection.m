//
//  RBItemSection.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBItemSection.h"

@implementation RBItemSection

+ (instancetype)sectionWithItems:(NSArray<RBWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    RBItemSection *item = [[self alloc] init];
    if (items.count) {
        [item.items addObjectsFromArray:items];
    }

    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;

    return item;
}

- (NSMutableArray<RBWordItem *> *)items
{
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
