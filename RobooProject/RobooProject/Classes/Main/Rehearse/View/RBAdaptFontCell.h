//
//  RBAdaptFontCell.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/1.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBParagraph.h"

@interface RBAdaptFontCell : UITableViewCell

+ (instancetype)adaptFontCellWithTableView:(UITableView *)tableView;

/** 段model */
@property (nonatomic, strong) RBParagraph *paragraph;

@end
