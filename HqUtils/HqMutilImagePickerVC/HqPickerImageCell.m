//
//  HqPickerImageCell.m
//  HqUtils
//
//  Created by hehuiqi on 7/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPickerImageCell.h"

@implementation HqPickerImageCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
   
    _showImageView = [[UIImageView alloc] init];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.clipsToBounds = YES;
    [self addSubview:_showImageView];
    
    _checkImageView = [[UIImageView alloc] init];
    _checkImageView.image = [UIImage imageNamed:@"AssetsPickerChecked"];
    [self addSubview:_checkImageView];    
    
}
- (void)setPickerModel:(HqMutilImagePickerModel *)pickerModel{
    _pickerModel = pickerModel;
    if (_pickerModel) {
        self.checkImageView.hidden = !pickerModel.selected;
//        self.showImageView.image = pickerModel.image;
        [self getAssetSmallImageWithAssect:pickerModel.phAsset callback:^(UIImage *image) {
            self.showImageView.image = image;
        }];
    }
}

- (void)getAssetSmallImageWithAssect:(PHAsset *)asset callback:(void(^)(UIImage *image))callback{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.version = PHImageRequestOptionsVersionOriginal;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    PHImageManager *phImageM =  [PHImageManager defaultManager];
    CGFloat width = SCREEN_WIDTH/4.0;
    CGFloat heiht  = width;
    [phImageM requestImageForAsset:asset targetSize:CGSizeMake(width, heiht) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callback(result);
    }];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _showImageView.frame = self.bounds;
    CGFloat checkWidth = 30;
    CGFloat x = self.bounds.size.width - checkWidth-5;
    CGFloat y = 5;
    _checkImageView.frame = CGRectMake(x, y, checkWidth, checkWidth);
}

@end
