//
//  HKViewMarco.h
//  HKBaseDemo
//
//  Created by hukaiyin on 16/7/31.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#ifndef ColorAndFontMarco_h
#define ColorAndFontMarco_h

#pragma mark - Frame

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define hNavigationBarHeight 64
#define hFooterTabBarHeight 49

#pragma mark - Color

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define YJCorl(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]


#define color_yellow UIColorFromRGB(0xffd800)
#define color_green [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define color_mask [UIColor colorWithWhite:0. alpha:.6]
#define color_line [UIColor colorWithRed:204/255. green:204/255. blue:204/255. alpha:1]
#define color_black [UIColor colorWithRed:0.118 green:0.133 blue:0.153 alpha:1.000]
#endif /* ColorAndFontMarco_h */
