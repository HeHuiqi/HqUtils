//
//  HqRichTextContentView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqRichTextContentView.h"

@implementation HqRichTextContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UIView *contentView = self;

    [contentView addSubview:self.contentLab];
    [contentView addSubview:self.firstImageView];
    [contentView addSubview:self.bottomView];
    CGFloat leftSpace = kZoomValue(15);
    CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
    self.contentLab.preferredMaxLayoutWidth = contentW;
    
    
    
}

- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = SetFont(16);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}
- (UIImageView *)firstImageView{
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
//        _firstImageView.clipsToBounds = YES;
//        _firstImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _firstImageView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = HqRandomColor;
    }
    return _bottomView;
}


- (CGSize)intrinsicContentSize{

    
    CGSize labSize = self.contentLab.intrinsicContentSize;
    CGSize imageSize = self.imageSize;
    CGFloat bottomH = kZoomValue(40) + 20;
    
    CGSize size = [super intrinsicContentSize];
    size.width = SCREEN_WIDTH;
    size.height = labSize.height + imageSize.height + bottomH;
    
    NSLog(@"intrinsicContentSize==%@",@(size));

    return size;
}
- (void)setCellModel:(HqCellModel *)cellModel{
    _cellModel = cellModel;
    if (_cellModel) {

        _contentLab.text = cellModel.content;
         
         CGFloat leftSpace = kZoomValue(15);
         CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
         NSURL *url = [NSURL URLWithString:cellModel.imageUrl];
         weakly(self);

        NSLog(@"加载图片。。。");

         [self.firstImageView sd_setImageWithURL:url  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
             strongly(self);
             if (image) {
                 NSLog(@"加载图片完成");
                 
                 NSLog(@"image==%@",image);

                 CGFloat scaleH = image.size.height/image.size.width;
                 CGFloat imageH = contentW*scaleH;
                 self.imageSize  = CGSizeMake(contentW, imageH);
                 [self invalidateIntrinsicContentSize];
                 [self setNeedsLayout];
             }
             
         }];
        
       
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftSpace = kZoomValue(15);
    CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
    CGSize labSize = self.contentLab.intrinsicContentSize;
    CGSize imageSize = self.imageSize;

//    NSLog(@"imageSize==%@",@(imageSize));
    self.contentLab.frame = CGRectMake(leftSpace, 0, contentW, labSize.height);
    self.firstImageView.frame = CGRectMake(leftSpace, CGRectGetMaxY(self.contentLab.frame), contentW, imageSize.height);
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.firstImageView.frame), SCREEN_WIDTH, kZoomValue(40));

    
}


@end
