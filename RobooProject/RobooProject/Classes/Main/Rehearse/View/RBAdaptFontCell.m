//
//  RBAdaptFontCell.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/1.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBAdaptFontCell.h"

@interface RBAdaptFontCell ()

/** <#digest#> */
@property (weak, nonatomic) UILabel *myDateLabel;

/** <#digest#> */
@property (weak, nonatomic) UILabel *myTextLabel;

@end


@implementation RBAdaptFontCell

+ (instancetype)adaptFontCellWithTableView:(UITableView *)tableView
{
    static NSString *const adaptFontCellID = @"adaptFontCellID";

    RBAdaptFontCell *cell = [tableView dequeueReusableCellWithIdentifier:adaptFontCellID];

    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adaptFontCellID];
    }


    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIOnceRBAdaptFontCell];
    }

    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnceRBAdaptFontCell];
}

- (void)setupUIOnceRBAdaptFontCell
{

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (void)setParagraph:(RBParagraph *)paragraph
{
    self.myTextLabel.attributedText = paragraph.attWords;
    self.myDateLabel.text = paragraph.date;
}


- (UILabel *)myDateLabel
{
    if(_myDateLabel == nil)
    {

        UILabel *label = [[UILabel alloc] init];

        [self.contentView addSubview:label];

        _myDateLabel = label;


        label.textColor = [UIColor blackColor];

        label.font = AdaptedFontSize(KDateLabelFontSize);

        [label mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(KTopSpace);
            make.left.mas_equalTo(KLeftSpace);
            make.right.mas_equalTo(-KRightSpace);

        }];

    }

    return _myDateLabel;
}


- (UILabel *)myTextLabel
{
    if(_myTextLabel == nil)
    {


        UILabel *label = [[UILabel alloc] init];

        [self.contentView addSubview:label];

        _myTextLabel = label;


        label.textColor = [UIColor grayColor];

        label.font = AdaptedFontSize(KTextLabelFontSize);


        label.numberOfLines = 0;


        [label mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(self.myDateLabel.mas_bottom).offset(KDateMarginToText);
            make.left.mas_equalTo(KLeftSpace);
            make.right.mas_equalTo(-KRightSpace);


        }];

    }
    return _myTextLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
