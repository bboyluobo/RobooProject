//
//  RBCollectionViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBBaseViewController.h"
#import "RBElementsFlowLayout.h"
#import "RBVerticalFlowLayout.h"
#import "RBHorizontalFlowLayout.h"

@class RBCollectionViewController;
@protocol RBCollectionViewControllerDataSource <NSObject>

@required
// 需要返回对应的布局
- (UICollectionViewLayout *)collectionViewController:(RBCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end



@interface RBCollectionViewController : RBBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, RBCollectionViewControllerDataSource>
/** <#digest#> */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
