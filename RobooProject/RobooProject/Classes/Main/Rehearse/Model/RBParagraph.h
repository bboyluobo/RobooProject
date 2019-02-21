//
//  RBParagraph.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/1.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN const CGFloat KTopSpace;
UIKIT_EXTERN const CGFloat KLeftSpace;
UIKIT_EXTERN const CGFloat KRightSpace;
UIKIT_EXTERN const CGFloat KDateLabelFontSize;
UIKIT_EXTERN const CGFloat KDateMarginToText;
UIKIT_EXTERN const CGFloat KTextLabelFontSize;
UIKIT_EXTERN const CGFloat kBottomSpace;


@interface RBParagraph : NSObject

/** 字  */
@property (nonatomic, copy) NSString *words;

/** 日期 */
@property (nonatomic, copy) NSString *date;

/** 富文本 */
@property (nonatomic, copy, readonly) NSAttributedString *attWords;

/** 段高度 */
@property (nonatomic, assign, readonly) CGFloat height;

@end
