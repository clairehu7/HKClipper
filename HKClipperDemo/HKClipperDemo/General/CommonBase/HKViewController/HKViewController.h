//
//  HKViewController.h
//  HKBaseNavigationDemo
//
//  Created by hukaiyin on 16/6/27.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKViewController : UIViewController

- (void)creaBackBtnWithTitle:(NSString *)title;
- (void)creatLeftBtnWithTitle:(NSString *)title;
- (void)creaRightBtnWithTitle:(NSString *)title;

- (void)backBtnTUI:(UIButton *)btn;
- (void)leftBtnTUI:(UIButton *)btn;
- (void)rightBtnTUI:(UIButton *)btn;

@end
