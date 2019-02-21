//
//  RBSettingCell.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/15.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RBWordItem;

@interface RBSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;

/** 静态单元格模型 */
@property (nonatomic, strong)  RBWordItem *item;

@end
