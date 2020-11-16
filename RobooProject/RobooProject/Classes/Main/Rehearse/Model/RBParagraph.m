//
//  RBParagraph.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/1.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBParagraph.h"

const CGFloat KTopSpace = 10;
const CGFloat KLeftSpace = 15;
const CGFloat KRightSpace = 15;
const CGFloat KDateLabelFontSize = 17;
const CGFloat KDateMarginToText = 10;
const CGFloat KTextLabelFontSize = 15;
const CGFloat kBottomSpace = 10;

@implementation RBParagraph
{
    NSAttributedString *_attWords;
    CGFloat _height;
}

- (NSAttributedString *)attWords
{
    if(!_attWords)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;

        NSAttributedString *arrS = [[NSAttributedString alloc] initWithString:self.words attributes:@{NSFontAttributeName : AdaptedFontSize(KTextLabelFontSize), NSParagraphStyleAttributeName : paragraphStyle}];

        _attWords = arrS;
    }
    return _attWords;
}

- (CGFloat)height
{
    if(!_height)
    {
        _height += KTopSpace;
        _height += kBottomSpace;
        _height += KDateMarginToText;
        _height += [self.attWords boundingRectWithSize:CGSizeMake(kScreenWidth - KLeftSpace - KRightSpace, INFINITY) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

        _height += [self.date boundingRectWithSize:CGSizeMake(kScreenWidth - KLeftSpace - KRightSpace, INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : AdaptedFontSize(KDateLabelFontSize)} context:nil].size.height;
        // 向上取整
        _height = ceilf(_height);
    }
    return _height;
}

@end
