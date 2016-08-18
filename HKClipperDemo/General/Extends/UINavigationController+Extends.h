//
//  UINavigationController+Extends.h
//  HKBaseNavigationDemo
//
//  Created by hukaiyin on 16/6/28.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extends)

- (void)updateBarWithTranslucent:(BOOL)flag barTintColor:(UIColor *)barTintColor tintColor:(UIColor *)tintColor shadowImage:(UIImage *)shadowImage;

- (void)backToVCWithClassName:(NSString *)className;

@end
