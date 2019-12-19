//
//  HqNineBoxView.m
//  LC
//
//  Created by hehuiqi on 2019/11/19.
//  Copyright © 2019 youfu. All rights reserved.
//

#import "HqNineBoxView.h"

@interface HqNineBoxView ()

@property(nonatomic,strong) NSMutableArray *imageViews;

@end
@implementation HqNineBoxView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (CGFloat)boxItemHeight{
    if (_boxItemHeight == 0) {
        CGFloat lefRightSpace = kZoomValue(24);
        CGFloat itemTotalSpace = kZoomValue(10);
        CGFloat allSpace = (lefRightSpace+itemTotalSpace);
        _boxItemHeight = (SCREEN_WIDTH-allSpace)/3.0;
    }
    return _boxItemHeight;
}
- (CGFloat)boxItemSpace{
    return kZoomValue(5);
}
- (void)setup{
    self.clipsToBounds = YES;
    self.imageViews = [[NSMutableArray alloc] init];
    for (int i = 0; i<9; i++) {
        UILabel *imgv = [[UILabel alloc] init];
//        imgv.contentMode = UIViewContentModeScaleAspectFill;
//        imgv.clipsToBounds = YES;
        imgv.hidden = YES;
        imgv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgv:)];
        [imgv addGestureRecognizer:tap];
        imgv.backgroundColor = [UIColor redColor];
        [self addSubview:imgv];
        [self.imageViews addObject:imgv];
    }
}
- (void)tapImgv:(UITapGestureRecognizer *)tap{
    UIImageView *imgv = (UIImageView *)tap.view;
    NSLog(@"imv.tag=%@",@(imgv.tag));
}
- (void)setImageDatas:(NSArray *)imageDatas{
    _imageDatas = imageDatas;
    if (_imageDatas.count>0) {
        
        CGFloat imgH = self.boxItemHeight;
        CGFloat imgSpace = self.boxItemSpace;
        NSInteger imgCount = self.imageDatas.count;
        if (imgCount>1) {
            if (imgCount<4) {
                self.boxHeight = 1 * (imgH+imgSpace);
            }else if (imgCount>=4 && imgCount<7) {
                self.boxHeight = 2 * (imgH+imgSpace);
            }else{
                self.boxHeight = 3 * (imgH+imgSpace);
            }
        }else{
            self.boxHeight = 2*imgH;
        }
        NSLog(@"boxHeight==%@",@(self.boxHeight));
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIImageView *imgv in self.imageViews) {
        imgv.hidden = YES;
        imgv.tag = 0;
    }
    CGFloat imgH = self.boxItemHeight;
    CGFloat imgW = imgH;
    CGFloat imgSpace = self.boxItemSpace;
    NSInteger imgCount = self.imageDatas.count;

    for (int i = 0; i<imgCount; i++) {
        UILabel *imgv = self.imageViews[i];
        imgv.text = @(i).stringValue;
        imgv.tag = i+1;
        imgv.hidden = NO;
        switch (imgCount) {
            case 1:
            {
                CGFloat imgw = imgW/2.0+imgW;
                CGFloat imgh = imgW*2;
                imgv.frame = CGRectMake(0, 0, imgw, imgh);
                break;
            }
                break;
            case 4:
            {
                CGFloat x = (i%2)*(imgW+imgSpace);
                CGFloat y = (i/2)*(imgW+imgSpace);
                imgv.frame = CGRectMake(x, y, imgW, imgH);
            }
                break;
            default:
            {
                CGFloat x = (i%3)*(imgW+imgSpace);
                CGFloat y = (i/3)*(imgW+imgSpace);
                imgv.frame = CGRectMake(x, y, imgW, imgH);
            }
                break;
        }

    }


}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
