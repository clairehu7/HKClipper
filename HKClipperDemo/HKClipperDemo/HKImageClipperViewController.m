//
//  HKImageClipperViewController.m
//  HKBaseDemo
//
//  Created by hukaiyin on 16/8/5.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "HKImageClipperViewController.h"

@interface HKImageClipperViewController ()
@property (nonatomic, strong) HKClipperVeiw *clipperView;
@end

@implementation HKImageClipperViewController

#pragma mark - Life Cycle
- (instancetype)initWithBaseImg:(UIImage *)baseImg resultImgSize:(CGSize)resultImgSize clipperType:(ClipperType)type {
    self = [super init];
    if (self) {        
        _clipperView = [[HKClipperVeiw alloc]init];
        _clipperView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _clipperView.resultImgSize = resultImgSize;
        //baseImg 的大小需依赖 resultImgSize 计算，所以 需在 resultImgSize 被赋值后才可赋值
        _clipperView.baseImg = baseImg;
        _clipperView.type = type;
        [self.view addSubview:_clipperView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load
- (void)loadSubViews {
    [self loadNav];
}

-(void)loadNav {
    self.title = @"选择图片";
    self.view.backgroundColor = [UIColor blackColor];
    [self creatLeftBtnWithTitle:@"取消"];
    [self creaRightBtnWithTitle:@"确认"];
}

#pragma mark - Btn Methods
- (void)leftBtnTUI:(UIButton *)btn {
    !_cancelClippedHandler?:_cancelClippedHandler();
}

-(void)rightBtnTUI:(UIButton *)btn {
    UIImage *clippedImg = [self.clipperView clipImg];
    !_successClippedHandler?:_successClippedHandler(clippedImg);
}
@end
