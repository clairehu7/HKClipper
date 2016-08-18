//
//  HKImageClipperViewController.h
//  HKBaseDemo
//
//  Created by hukaiyin on 16/8/5.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "HKViewController.h"
#import "HKClipperVeiw.h"

@interface HKImageClipperViewController : HKViewController

- (instancetype)initWithBaseImg:(UIImage *)baseImg
                  resultImgSize:(CGSize)resultImgSize
                    clipperType:(ClipperType)type;

@property (nonatomic, copy) void(^cancelClippedHandler)(void);
@property (nonatomic, copy) void(^successClippedHandler)(UIImage *clippedImage);
@end