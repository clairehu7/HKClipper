//
//  ViewController.m
//  HKClipperDemo
//
//  Created by hukaiyin on 16/8/17.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "ViewController.h"
#import "HKClipperHelper.h"

@interface ViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *clippedImageView; //显示结果图片
@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configHelper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKClipperHelper

- (void)configHelper {
    ClipperHelper.nav = self.navigationController;
    ClipperHelper.clippedImgSize = self.clippedImageView.frame.size;

    __weak typeof(self)weakSelf = self;

    ClipperHelper.clippedImageHandler = ^(UIImage *img) {
        weakSelf.clippedImageView.image = img;
    };
}

#pragma mark - UIActionSheet

- (void)takePhoto {
    UIActionSheet *_sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"拍照", @"相机胶卷", nil];
    [_sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    dispatch_after(0., dispatch_get_main_queue(), ^{
        if (buttonIndex == 0) {
            [ClipperHelper photoWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else if(buttonIndex == 1) {
            [ClipperHelper photoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    });
}

#pragma mark - Btn Methods

- (IBAction)imageTUI:(UIButton *)sender {
    ClipperHelper.clipperType = ClipperTypeImgMove;
    ClipperHelper.systemEditing = NO;
    ClipperHelper.isSystemType = NO;
    [self takePhoto];
}

- (IBAction)clipperTUI:(UIButton *)sender {
    ClipperHelper.clipperType = ClipperTypeImgStay;
    ClipperHelper.systemEditing = NO;
    ClipperHelper.isSystemType = NO;
    [self takePhoto];
}

- (IBAction)systemDontClipTUI:(UIButton *)sender {
    ClipperHelper.systemEditing = NO;
    ClipperHelper.isSystemType = YES;
    [self takePhoto];
}

- (IBAction)systemTUI:(UIButton *)sender {
    ClipperHelper.systemEditing = YES;
    ClipperHelper.isSystemType = YES;
    [self takePhoto];
}

@end
