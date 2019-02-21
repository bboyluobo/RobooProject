//
//  WhackGameViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhackGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *pausePlay;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *duneOne;
@property (weak, nonatomic) IBOutlet UIImageView *duneTwo;
@property (weak, nonatomic) IBOutlet UIImageView *duneThree;

@end
