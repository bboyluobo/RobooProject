//
//  UIView+RbNjHuFrame.m
//  PLMMPRJK
//
//  Created by Roobo on 2017/4/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "UIView+RBNjHuFrame.h"

@implementation UIView (RBNjHuFrame)

- (CGFloat)rb_x {
    return self.frame.origin.x;
}

- (void)setRb_x:(CGFloat)rb_x {
    CGRect frame = self.frame;
    frame.origin.x = rb_x;
    self.frame = frame;
}

- (CGFloat)rb_y {
    return self.frame.origin.y;
}

- (void)setRb_y:(CGFloat)rb_y {
    CGRect frame = self.frame;
    frame.origin.y = rb_y;
    self.frame = frame;
}

- (CGFloat)rb_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRb_right:(CGFloat)rb_right {
    CGRect frame = self.frame;
    frame.origin.x = rb_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)rb_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRb_bottom:(CGFloat)rb_bottom {
    
    CGRect frame = self.frame;
    
    frame.origin.y = rb_bottom - frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)rb_width {
    return self.frame.size.width;
}

- (void)setRb_width:(CGFloat)rb_width {
    CGRect frame = self.frame;
    frame.size.width = rb_width;
    self.frame = frame;
}

- (CGFloat)rb_height {
    return self.frame.size.height;
}

- (void)setRb_height:(CGFloat)rb_height {
    CGRect frame = self.frame;
    frame.size.height = rb_height;
    self.frame = frame;
}

- (CGFloat)rb_centerX {
    return self.center.x;
}

- (void)setRb_centerX:(CGFloat)rb_centerX {
    self.center = CGPointMake(rb_centerX, self.center.y);
}

- (CGFloat)rb_centerY {
    return self.center.y;
}

- (void)setRb_centerY:(CGFloat)rb_centerY {
    self.center = CGPointMake(self.center.x, rb_centerY);
}

- (CGPoint)rb_origin {
    return self.frame.origin;
}

- (void)setRb_origin:(CGPoint)rb_origin {
    CGRect frame = self.frame;
    frame.origin = rb_origin;
    self.frame = frame;
}

- (CGSize)rb_size {
    return self.frame.size;
}

- (void)setRb_size:(CGSize)rb_size {
    CGRect frame = self.frame;
    frame.size = rb_size;
    self.frame = frame;
}

@end
