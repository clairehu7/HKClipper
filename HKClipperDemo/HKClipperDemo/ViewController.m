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

    __weak typeof(self)weakSelf = self;

    [self configHelperWith:^(UIImage *img) {
        weakSelf.clippedImageView.image = img;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKClipperHelper

- (void)configHelperWith:(void(^)(UIImage *img))handler {
    [HKClipperHelper shareManager].nav = self.navigationController;
    [HKClipperHelper shareManager].clippedImgSize = self.clippedImageView.frame.size;
    [HKClipperHelper shareManager].clippedImageHandler = handler;
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
            [[HKClipperHelper shareManager] photoWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else if(buttonIndex == 1) {
            [[HKClipperHelper shareManager] photoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    });
}

#pragma mark - Btn Methods

- (IBAction)imageTUI:(UIButton *)sender {
    [HKClipperHelper shareManager].clipperType = ClipperTypeImgMove;
    [HKClipperHelper shareManager].systemEditing = NO;
    [HKClipperHelper shareManager].isSystemType = NO;
    [self takePhoto];
}

- (IBAction)clipperTUI:(UIButton *)sender {
    [HKClipperHelper shareManager].clipperType = ClipperTypeImgStay;
    [HKClipperHelper shareManager].systemEditing = NO;
    [HKClipperHelper shareManager].isSystemType = NO;
    [self takePhoto];
}

- (IBAction)systemDontClipTUI:(UIButton *)sender {
    [HKClipperHelper shareManager].systemEditing = NO;
    [HKClipperHelper shareManager].isSystemType = YES;
    [self takePhoto];
}

- (IBAction)systemTUI:(UIButton *)sender {
    [HKClipperHelper shareManager].systemEditing = YES;
    [HKClipperHelper shareManager].isSystemType = YES;
    [self takePhoto];
}

@end
