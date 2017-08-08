//
//  HKClipperHelper.m
//  HKClipperDemo
//
//  Created by hukaiyin on 2017/8/8.
//  Copyright © 2017年 hukaiyin. All rights reserved.
//

#import "HKClipperHelper.h"

@interface HKClipperHelper()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HKClipperHelper

+ (instancetype)shareManager {
    static HKClipperHelper *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    if (!self.isSystemType) {
        //自定义裁剪方式
        UIImage*image = [self turnImageWithInfo:info];
        HKImageClipperViewController *clipperVC = [[HKImageClipperViewController alloc]initWithBaseImg:image
                                                                                         resultImgSize:_clippedImgSize clipperType:self.clipperType];

        __weak typeof(self)weakSelf = self;
        clipperVC.cancelClippedHandler = ^(){
            [picker dismissViewControllerAnimated:YES completion:nil];
        };
        clipperVC.successClippedHandler = ^(UIImage *clippedImage){
            __strong typeof(self)strongSelf = weakSelf;
            !strongSelf.clippedImageHandler?:strongSelf.clippedImageHandler(clippedImage);
            [picker dismissViewControllerAnimated:YES completion:nil];
        };

        [picker pushViewController:clipperVC animated:YES];
    } else {
        //系统方式，区分是否需要裁剪
        NSString *imgKey;
        UIImage *image;
        if (!self.systemEditing) {
            imgKey = UIImagePickerControllerOriginalImage;
            image = [self turnImageWithInfo:info];
        } else {
            imgKey = UIImagePickerControllerEditedImage;
            image=[info objectForKey:imgKey];
        }
        UIImage *clippedImage = [info objectForKey:imgKey];
        !_clippedImageHandler?:_clippedImageHandler(clippedImage);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIImage *)turnImageWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    //类型为 UIImagePickerControllerOriginalImage 时调整图片角度
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp) {
            // 原始图片可以根据照相时的角度来显示，但 UIImage无法判定，于是出现获取的图片会向左转90度的现象。
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    return image;
}

- (void)photoWithSourceType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = type;
    imagePicker.allowsEditing = self.systemEditing;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self.nav presentViewController:imagePicker animated:YES completion:nil];
}

@end
