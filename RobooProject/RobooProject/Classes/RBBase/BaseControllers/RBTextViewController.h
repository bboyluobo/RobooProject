//
//  RBTextViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBNavUIBaseViewController.h"


@class RBTextViewController;
@protocol RBTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(RBTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(RBTextViewController *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(RBTextViewController *)textViewController;

@end


@protocol RBTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(RBTextViewController *)textViewController inputViewDone:(id)inputView;
@end


@interface RBTextViewController : RBNavUIBaseViewController<RBTextViewControllerDataSource, RBTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;

@end

#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (RBTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface RBTextViewControllerTextField : UITextField

@end
