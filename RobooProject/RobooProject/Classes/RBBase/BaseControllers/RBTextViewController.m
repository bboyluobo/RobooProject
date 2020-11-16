//
//  RBTextViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTextViewController.h"
#import "IQUIView+Hierarchy.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface RBTextViewController ()

/** <#digest#> */
@property (nonatomic, strong) NSArray<UITextField *> *requiredTextFields;

/** <#digest#> */
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation RBTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initKeyboard];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_returnKeyHandler) {
        [_returnKeyHandler setDelegate:nil];
        _returnKeyHandler = nil;
    }
}

#pragma mark - UITextViewDelegate, UITextFieldDelegate

#pragma mark - 处理 returnKey
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![IQKeyboardManager sharedManager].canGoNext) {
        [self textViewController:self inputViewDone:textField];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![IQKeyboardManager sharedManager].canGoNext && [text isEqualToString:@"\n"]) {
        [self textViewController:self inputViewDone:textView];
    }
    return YES;
}

#pragma mark - RBTextViewControllerDelegate
- (void)textViewController:(RBTextViewController *)textViewController inputViewDone:(id)inputView {
    NSLog(@"%@, %@", self.requiredTextFields, inputView);
}

#pragma mark - autoEmpty

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 九宫格 bug fix
    if ([@"➋➌➍➎➏➐➑➒" rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string.stringByTrim].stringByTrim;

    if (textField.isEmptyAutoEnable && (RBIsEmpty(textField.text.stringByTrim) || RBIsEmpty(current))) {
        if (RBIsEmpty(current)) {
            [self checkIsEmpty:YES textField:textField];
        }else
        {
            [self checkIsEmpty:NO textField:textField];
        }
    }

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.isEmptyAutoEnable) {
        [self checkIsEmpty:YES textField:textField];
    }
    return YES;
}


#pragma mark - 设置 btn的 enable
- (void)checkIsEmpty:(BOOL)isEmpty textField:(UITextField *)textField {
    if (RBIsEmpty(self.requiredTextFields)) {
        return;
    }

    if ([self respondsToSelector:@selector(textViewControllerRelationButtons:)]) {
        if (RBIsEmpty([self textViewControllerRelationButtons:self])) {
            return;
        }
    }else
    {
        return;
    }

    __block BOOL isButtonEnabled = !isEmpty;

    if (!isEmpty) {
        [self.requiredTextFields enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj != textField && RBIsEmpty(obj.text.stringByTrim)) {
                isButtonEnabled = NO;
                *stop = YES;
            }
        }];
    }

    [[self textViewControllerRelationButtons:self] enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = isButtonEnabled;
    }];
}



#pragma mark - 初始化
- (void)initKeyboard {
    // 键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = [self textViewControllerEnableAutoToolbar:self];
    manager.shouldPlayInputClicks = YES;
    manager.shouldShowToolbarPlaceholder = YES;

    [self requiredTextFields];
    [self initReturnKeyHandler];;
}



#pragma mark - RBTextViewControllerDataSource

- (BOOL)textViewControllerEnableAutoToolbar:(RBTextViewController *)textViewController
{
    return YES;
}

- (UIReturnKeyType)textViewControllerLastReturnKeyType:(RBTextViewController *)textViewController
{
    return UIReturnKeyDone;
}


- (NSArray<UITextField *> *)requiredTextFields {
    if(_requiredTextFields == nil)
    {
        NSArray *responsedInputViews = [self.view deepResponderViews];
        NSMutableArray<UITextField *> *array = [NSMutableArray array];
        [responsedInputViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj isKindOfClass:[UITextField class]]) {

                UITextField *field = (UITextField *)obj;
                field.delegate = self;

                if (field.isEmptyAutoEnable) {
                    [array addObject:field];
                }
            }

            if ([obj isKindOfClass:[UITextView class]]) {
                UITextView *textView = (UITextView *)obj;
                textView.delegate = self;
            }
        }];

        _requiredTextFields = array;
    }
    return _requiredTextFields;
}


- (void)initReturnKeyHandler {
    if(_returnKeyHandler == nil) {
        _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
        _returnKeyHandler.delegate = self;
        _returnKeyHandler.lastTextFieldReturnKeyType = [self textViewControllerLastReturnKeyType:self];
    }
}


- (void)dealloc
{
    _returnKeyHandler = nil;
}

@end



#pragma mark - RBTextViewControllerTextField

static void *isEmptyAutoEnableKey = &isEmptyAutoEnableKey;
@implementation UITextField (RBTextViewController)

- (void)setIsEmptyAutoEnable:(BOOL)isEmptyAutoEnable
{
    [self setAssociateValue:@(isEmptyAutoEnable) withKey:isEmptyAutoEnableKey];
}

- (BOOL)isEmptyAutoEnable
{
    return [(NSNumber *)[self getAssociatedValueForKey:isEmptyAutoEnableKey] boolValue];
}
@end

@implementation RBTextViewControllerTextField

- (NSString *)text {
    return ([[super text] stringByTrim]);
}


@end
