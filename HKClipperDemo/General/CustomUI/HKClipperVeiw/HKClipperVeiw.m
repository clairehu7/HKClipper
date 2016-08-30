//
//  HKClipperVeiw.m
//  HKBaseDemo
//
//  Created by hukaiyin on 16/8/9.
//  Copyright © 2016年 hukaiyin. All rights reserved.
//

#import "HKClipperVeiw.h"
#import "UIImage+ClipperExtends.h"

static const CGFloat minWidth = 60;
@interface HKClipperVeiw()
@property (nonatomic, strong) UIImageView *clipperView;
@property (nonatomic, strong) UIImageView *baseImgView;

@end

@implementation HKClipperVeiw {
    CGPoint panTouch;
    CGFloat scaleDistance; //缩放距离
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadSubViews];
}

- (void)loadSubViews {
    //    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.contentsGravity = kCAGravityResizeAspect;
}

#pragma mark - Public
- (UIImage *)clipImg {
    
    CGFloat scale = [UIScreen mainScreen].scale * self.baseImgView.image.size.width/self.baseImgView.frame.size.width;
    
    CGRect rect = [self convertRect:self.clipperView.frame toView:self.baseImgView];
    CGRect rect2 = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, scale *rect.size.width, scale * rect.size.height);
    
    CGImageRef cgImg = CGImageCreateWithImageInRect(self.baseImgView.image.CGImage, rect2);
    
    UIImage *clippedImg = [UIImage imageWithCGImage:cgImg];
    
    CGImageRelease(cgImg);
    return clippedImg;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    switch ([allTouches count]) {
        case 1:{
            panTouch = [[allTouches anyObject] locationInView:self];
            break;
        }
        case 2:{
            
            break;
        }
            
        default:
            break;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self willChangeValueForKey:@"crop"];
    NSSet *allTouches = [event allTouches];
    
    switch ([allTouches count])
    {
        case 1: {
            CGPoint touchCurrent = [[allTouches anyObject] locationInView:self];
            CGFloat x = touchCurrent.x - panTouch.x;
            CGFloat y = touchCurrent.y - panTouch.y;
            
            switch (self.type) {
                case ClipperTypeImgMove: {
                    self.baseImgView.center = CGPointMake(self.baseImgView.center.x + x, self.baseImgView.center.y + y);
                    break;
                }
                case ClipperTypeImgStay: {
                    self.clipperView.center = CGPointMake(self.clipperView.center.x + x, self.clipperView.center.y + y);
                    break;
                }
            }
            panTouch = touchCurrent;
            
        } break;
        case 2: {
            switch (self.type) {
                case ClipperTypeImgMove: {
                     [self scaleView:self.baseImgView touches:[allTouches allObjects]];
                    break;
                }
                case ClipperTypeImgStay: {
                    [self scaleView:self.clipperView touches:[allTouches allObjects]];
                    break;
                }
            }
        } break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (self.type) {
        case ClipperTypeImgMove: {
            [self correctBackImgView];
            break;
        }
        case ClipperTypeImgStay: {
            [self correctClipperView];
            break;
        }
    }
}

- (void)correctBackImgView {
    CGFloat x = self.baseImgView.frame.origin.x;
    CGFloat y = self.baseImgView.frame.origin.y;
    CGFloat height = self.baseImgView.frame.size.height;
    CGFloat width = self.baseImgView.frame.size.width;
    
    if (width < self.clipperView.frame.size.width) {
        width = self.clipperView.frame.size.width;
        height = width / self.baseImgView.frame.size.width * height;
    }
    
    if (height < self.clipperView.frame.size.height) {
        height = self.clipperView.frame.size.height;
        width = height / self.baseImgView.frame.size.height * width;
    }
    
    if(x > self.clipperView.frame.origin.x) {
        x = self.clipperView.frame.origin.x;
    } else if (x <(self.clipperView.frame.origin.x + self.clipperView.frame.size.width - width)) {
        x = self.clipperView.frame.origin.x + self.clipperView.frame.size.width - width;
    }
    
    if (y > self.clipperView.frame.origin.y) {
        y = self.clipperView.frame.origin.y;
    } else if (y < (self.clipperView.frame.origin.y + self.clipperView.frame.size.height - height)) {
        y = self.clipperView.frame.origin.y + self.clipperView.frame.size.height - height;
    }
    
    self.baseImgView.frame = CGRectMake(x, y, width, height);
}

- (void)correctClipperView {
    CGFloat width = self.clipperView.frame.size.width;
    CGFloat height;
    if (width < minWidth) {
        width = minWidth;
    }
    if (width > [UIScreen mainScreen].bounds.size.width) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    height = width/self.resultImgSize.width * self.resultImgSize.height;
    
    CGFloat x = self.clipperView.frame.origin.x;
    CGFloat y = self.clipperView.frame.origin.y;
    if (x < 0) {
        x = 0;
    }
    if(x  > [UIScreen mainScreen].bounds.size.width - width){
        x = [UIScreen mainScreen].bounds.size.width - width;
    }
    if (y < 0) {
        y = 0;
    }
    if(y > [UIScreen mainScreen].bounds.size.height - height - 64){
        y =[UIScreen mainScreen].bounds.size.height - height - 64;
    }
    
    self.clipperView.frame = CGRectMake(x, y, width, height);
}

#pragma mark - Utilities
//根据两点缩放View
- (void)scaleView:(UIView *)view touches:(NSArray *)touches {
    CGPoint touch1 = [[touches objectAtIndex:0] locationInView:self];
    CGPoint touch2 = [[touches objectAtIndex:1] locationInView:self];
    
    CGFloat distance = [self distanceBetweenTwoPoints:touch1 toPoint:touch2];
    if (scaleDistance>0) {
        CGRect imgFrame=view.frame;
        
        if (distance>scaleDistance+2) {
            imgFrame.size.width+=10;
            scaleDistance=distance;
        }
        if (distance<scaleDistance-2) {
            imgFrame.size.width -= 10;
            scaleDistance=distance;
        }
        
        imgFrame.size.height=CGRectGetHeight(view.frame)*imgFrame.size.width/CGRectGetWidth(view.frame);
        float addwidth=imgFrame.size.width-view.frame.size.width;
        float addheight=imgFrame.size.height-view.frame.size.height;
        
        if (imgFrame.size.width != 0 && imgFrame.size.height != 0) {
            view.frame=CGRectMake(imgFrame.origin.x-addwidth/2.0f, imgFrame.origin.y-addheight/2.0f, imgFrame.size.width, imgFrame.size.height);
        }
        
    }else {
        scaleDistance = distance;
    }
}

- (CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    CGFloat x = toPoint.x - fromPoint.x;
    CGFloat y = toPoint.y - fromPoint.y;
    
    return sqrtf(x * x + y * y);
}

#pragma mark - Getters & Setters
- (void)setBaseImg:(UIImage *)baseImg {
    _baseImg = baseImg;
    
    //调整背景图片大小
    CGFloat width = _baseImg.size.width;
    CGFloat height = _baseImg.size.height;
    if (width != self.frame.size.width) {
        width = self.frame.size.width;
    }
    height = _baseImg.size.height / _baseImg.size.width * width;
    
    if (height < self.clipperView.frame.size.height) {
        height = self.clipperView.frame.size.height;
    }
    
    width = _baseImg.size.width / _baseImg.size.height * height;
    
    UIImage *img = [_baseImg scaledToSize:CGSizeMake(width, height) withScale:NO];
    
    self.baseImgView.image = img;
    self.baseImgView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    [self correctBackImgView];
}

- (UIImageView *)baseImgView {
    if (!_baseImgView) {
        _baseImgView = [[UIImageView alloc]init];
        [self addSubview:_baseImgView];
        [self sendSubviewToBack:_baseImgView];
    }
    return _baseImgView;
}

- (void)setResultImgSize:(CGSize)resultImgSize {
    _resultImgSize = resultImgSize;
    [self clipperView];
}

- (UIImageView *)clipperView {
    if (!_clipperView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 64;
        
        if (self.resultImgSize.width > self.resultImgSize.height) {
            height = [UIScreen mainScreen].bounds.size.width / self.resultImgSize.width * self.resultImgSize.height;
        } else {
            width = [UIScreen mainScreen].bounds.size.height / self.resultImgSize.height * self.resultImgSize.width;
        }
        
        CGFloat y = (self.frame.size.height - height) / 2;
        CGFloat x = (self.frame.size.width - width) / 2;
        _clipperView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        
//        _clipperView.image = [UIImage imageNamed:@"img_clipper_border"];        
        _clipperView.layer.borderColor = [UIColor colorWithRed:0.369 green:0.882 blue:0.502 alpha:1.000].CGColor;
        _clipperView.layer.borderWidth = 2;
        
        [self addSubview:_clipperView];
    }
    return _clipperView ;
}

@end