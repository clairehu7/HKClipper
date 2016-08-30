//
//  UIImage+ClipperExtends.h
//  HKClipperDemo
//
//  Created by hukaiyin on 16/8/30.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipperExtends)
/**
 *  缩放图片
 *
 *  @param newSize   图片尺寸
 *  @param withScale 是否 * [UIScreen mainScreen].scale
 *
 *  @return 处理后的图片
 */
-(UIImage*)scaledToSize:(CGSize)newSize withScale:(BOOL)withScale;
@end
