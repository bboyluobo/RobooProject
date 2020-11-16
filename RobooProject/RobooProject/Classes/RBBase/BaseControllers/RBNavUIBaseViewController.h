//
//  RBNavUIBaseViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBNavigationBar.h"
#import "RBNavigationController.h"

@class RBNavUIBaseViewController;
@protocol RBNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(RBNavUIBaseViewController *)navUIBaseViewController;
@end

@interface RBNavUIBaseViewController : UIViewController<RBNavigationBarDelegate, RBNavigationBarDataSource, RBNavUIBaseViewControllerDataSource>

/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;
/**  */
@property (weak, nonatomic) RBNavigationBar *rb_navgationBar;

@end
