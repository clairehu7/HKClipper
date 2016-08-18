//
//  UIBarButtonItem+Extends.m
//  HKBaseDemo
//
//  Created by hukaiyin on 16/8/5.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "UIBarButtonItem+Extends.h"

@implementation UIBarButtonItem (Extends)

+ (UIBarButtonItem *)barItemWithTarget:(id)target
                                action:(SEL)action
                      forControlEvents:(UIControlEvents)controlEvents
                                 img:(UIImage *)img {
    
    UIButton *customBtn = [[UIButton alloc]initWithFrame:(CGRect){CGPointZero,img.size}];
    
    CGPoint center = customBtn.center;
    UIEdgeInsets extendEdge = UIEdgeInsetsMake(0, -6, 0, 0);
    customBtn.frame = CGRectMake(0, 0, customBtn.frame.size.width + extendEdge.left + extendEdge.right, customBtn.frame.size.height + extendEdge.top + extendEdge.bottom);
    customBtn.center = center;
    customBtn.imageEdgeInsets = extendEdge;
    
    [customBtn addTarget:target action:action forControlEvents:controlEvents];
    [customBtn setImage:img forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc]initWithCustomView:customBtn];
}

@end
