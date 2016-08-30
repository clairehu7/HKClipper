//
//  UIImage+ClipperExtends.m
//  HKClipperDemo
//
//  Created by hukaiyin on 16/8/30.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "UIImage+ClipperExtends.h"

@implementation UIImage (ClipperExtends)
-(UIImage*)scaledToSize:(CGSize)newSize withScale:(BOOL)withScale {
    
    CGFloat scale = 1;
    if (withScale) {
        scale = [UIScreen mainScreen].scale;
    }
    newSize = (CGSize){newSize.width * scale, newSize.height * scale};
    // Create a graphics image context
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    //    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:(CGRect){CGPointZero, newSize}];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
