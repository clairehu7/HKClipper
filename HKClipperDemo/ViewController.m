//
//  ViewController.m
//  HKClipperDemo
//
//  Created by hukaiyin on 16/8/17.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "ViewController.h"

#import "HKImageClipperViewController.h"

@interface ViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) ClipperType clipperType;
@property (weak, nonatomic) IBOutlet UIImageView *clippedImageView; //显示结果图片
@property (nonatomic, assign) BOOL systemEditing;
@property (nonatomic, assign) BOOL isSystemType;
@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (!self.isSystemType) {
        //自定义裁剪方式
        UIImage*image = [self turnImageWithInfo:info];
        HKImageClipperViewController *clipperVC = [[HKImageClipperViewController alloc]initWithBaseImg:image
                                                                                         resultImgSize:self.clippedImageView.frame.size clipperType:self.clipperType];
        
        __weak typeof(self)weakSelf = self;
        clipperVC.cancelClippedHandler = ^(){
            [picker dismissViewControllerAnimated:YES completion:nil];
        };
        clipperVC.successClippedHandler = ^(UIImage *clippedImage){
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.clippedImageView.image = clippedImage;
            //            strongSelf.layerView.layer.contents =(__bridge id _Nullable)(clippedImage.CGImage);
            //            strongSelf.layerView.contentMode = UIViewContentModeScaleAspectFit;
            //            strongSelf.layerView.layer.contentsGravity = kCAGravityResizeAspect;
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
        self.clippedImageView.image = [info objectForKey:imgKey];
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

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    dispatch_after(0., dispatch_get_main_queue(), ^{
        if (buttonIndex == 0) {
            [self photoWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else if(buttonIndex == 1) {
            [self photoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    });
}

- (void)photoWithSourceType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = type;
    imagePicker.allowsEditing = self.systemEditing;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Btn Methods
- (IBAction)imageTUI:(UIButton *)sender {
    self.clipperType = ClipperTypeImgMove;
    self.systemEditing = NO;
    self.isSystemType = NO;
    [self takePhoto];
}

- (IBAction)clipperTUI:(UIButton *)sender {
    self.clipperType = ClipperTypeImgStay;
    self.systemEditing = NO;
    self.isSystemType = NO;
    [self takePhoto];
}

- (IBAction)systemDontClipTUI:(UIButton *)sender {
    self.systemEditing = NO;
    self.isSystemType = YES;
    [self takePhoto];
}

- (IBAction)systemTUI:(UIButton *)sender {
    self.systemEditing = YES;
    self.isSystemType = YES;
    [self takePhoto];
}

- (void)takePhoto {
    UIActionSheet *_sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"拍照", @"相机胶卷", nil];
    [_sheet showInView:[UIApplication sharedApplication].keyWindow];
}


@end
