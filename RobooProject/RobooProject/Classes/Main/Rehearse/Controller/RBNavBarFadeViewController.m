//
//  RBNavBarFadeViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBNavBarFadeViewController.h"
#import "RBExpandHeader.h"
#import "RBExpandImageView.h"
@interface RBNavBarFadeViewController ()
{
    UIStatusBarStyle _statusBarStyle;
}

/** 扩展头部视图 */
@property (nonatomic, strong) RBExpandHeader *expandHander;

@end

@implementation RBNavBarFadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = 0;
    self.tableView.contentInset = contentInset;

    UIImageView *imageView = [[RBExpandImageView alloc] initWithImage:[UIImage imageNamed:@"rbImage4.jpg"]];

    imageView.rb_height = 128;
    imageView.rb_width = kScreenWidth;

    _expandHander = [RBExpandHeader expandWithScrollView:self.tableView expandView:imageView];

    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];

    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row];

    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat kNavBarHeight = -self.rb_navgationBar.height;

    CGPoint contentOffset = scrollView.contentOffset;

    UIButton *leftBtn = (UIButton *)self.rb_navgationBar.leftView;
    UIButton *rightBtn = (UIButton *)self.rb_navgationBar.rightView;

    NSLog(@"%@", NSStringFromCGPoint(contentOffset));

    if (contentOffset.y <= kNavBarHeight) {

        self.rb_navgationBar.title = [self changeTitle:@"我的" color:[UIColor redColor]];

        leftBtn.selected = NO;
        rightBtn.selected = NO;

        self.rb_navgationBar.backgroundColor = [UIColor clearColor];

        _statusBarStyle = UIStatusBarStyleLightContent;

    }else if (contentOffset.y > kNavBarHeight && contentOffset.y < 0)
    {
        self.rb_navgationBar.title = [self changeTitle:@"我的" color:[UIColor redColor]];
        leftBtn.selected = NO;
        rightBtn.selected = NO;

        self.rb_navgationBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:(1 - contentOffset.y / kNavBarHeight)];

        _statusBarStyle = UIStatusBarStyleLightContent;

    }else if (contentOffset.y >= 0)
    {
        self.rb_navgationBar.title = [self changeTitle:@"我的" color:[UIColor greenColor]];
        leftBtn.selected = YES;
        rightBtn.selected = YES;
        self.rb_navgationBar.backgroundColor = [UIColor whiteColor];

        _statusBarStyle = UIStatusBarStyleDefault;
    }

    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - RBNavUIBaseViewControllerDataSource

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

/**头部标题*/
- (NSMutableAttributedString*)rbNavigationBarTitle:(RBNavigationBar *)navigationBar
{
    return [self changeTitle:self.navigationItem.title ?: self.title color:[UIColor redColor]];
}


/** 背景色 */
- (UIColor *)rbNavigationBackgroundColor:(RBNavigationBar *)navigationBar
{
    return [UIColor clearColor];
}

/** 是否隐藏底部黑线 */
- (BOOL)rbNavigationIsHideBottomLine:(RBNavigationBar *)navigationBar
{
    return YES;
}


/** 导航条左边的按钮 */
- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{

    [leftButton setImage:[UIImage imageNamed:@"tabBar_new_click_icon"] forState:UIControlStateSelected];

    return [UIImage imageNamed:@"tabBar_new_icon"];
}
/** 导航条右边的按钮 */
- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RBNavigationBar *)navigationBar
{
    [rightButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateSelected];

    return [UIImage imageNamed:@"mine-setting-icon-click"];
}



#pragma mark - RBNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{

}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(RBNavigationBar *)navigationBar
{

}


#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle color:(UIColor *)color
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];

    [title addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];

    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, title.length)];

    return title;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] postNotificationName:RBTableViewControllerDeallocNotification object:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
