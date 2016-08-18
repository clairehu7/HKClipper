//
//  UINavigationController+Extends.m
//  HKBaseNavigationDemo
//
//  Created by hukaiyin on 16/6/28.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "UINavigationController+Extends.h"

@implementation UINavigationController (Extends)

- (void)backToVCWithClassName:(NSString *)className {
    Class vcClass = NSClassFromString(className);
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:vcClass]) {
            [self popToViewController:vc animated:YES];
        }
    }
}

- (void)updateBarWithTranslucent:(BOOL)flag barTintColor:(UIColor *)barTintColor tintColor:(UIColor *)tintColor shadowImage:(UIImage *)shadowImage {
    self.navigationBar.translucent = flag;
    self.navigationBar.barTintColor = barTintColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:tintColor};
    self.navigationBar.tintColor = tintColor;
    self.navigationBar.shadowImage = shadowImage;
}

@end
