//
//  UIImage+Extends.h
//  HKBaseNavigationDemo
//
//  Created by hukaiyin on 16/6/26.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extends)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  缩放图片
 *
 *  @param newSize   图片尺寸
 *  @param withScale 是否 * [UIScreen mainScreen].scale
 *
 *  @return 处理后的图片
 */
-(UIImage*)scaledToSize:(CGSize)newSize withScale:(BOOL)withScale;

-(UIImage*)getSubImage:(CGRect)rect;

@end
