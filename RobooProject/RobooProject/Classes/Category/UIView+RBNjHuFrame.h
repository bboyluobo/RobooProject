//
//  UIView+RBNjHuFrame.h
//  PLMMPRJK
//
//  Created by Roobo on 2017/4/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RBNjHuFrame)

@property (nonatomic) CGFloat rb_x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat rb_y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat rb_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat rb_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat rb_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat rb_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat rb_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat rb_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint rb_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  rb_size;        ///< Shortcut for frame.size.

@end
