//
//  UIBarButtonItem+Extends.h
//  HKBaseDemo
//
//  Created by hukaiyin on 16/8/5.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extends)
+ (UIBarButtonItem *)barItemWithTarget:(id)target
                                action:(SEL)action
                      forControlEvents:(UIControlEvents)controlEvents
                                   img:(UIImage *)img;
@end
