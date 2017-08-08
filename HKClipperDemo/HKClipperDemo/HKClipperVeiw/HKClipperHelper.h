//
//  HKClipperHelper.h
//  HKClipperDemo
//
//  Created by hukaiyin on 2017/8/8.
//  Copyright © 2017年 hukaiyin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HKImageClipperViewController.h"

#define ClipperHelper [HKClipperHelper shareManager]

@interface HKClipperHelper : NSObject

+ (instancetype)shareManager;
@property (nonatomic, copy) void(^clippedImageHandler)(UIImage *img);
@property (nonatomic, assign) CGSize clippedImgSize;
@property (nonatomic, weak) UINavigationController *nav;
@property (nonatomic, assign) ClipperType clipperType;
@property (nonatomic, assign) BOOL systemEditing;
@property (nonatomic, assign) BOOL isSystemType;

- (void)photoWithSourceType:(UIImagePickerControllerSourceType)type;

@end
