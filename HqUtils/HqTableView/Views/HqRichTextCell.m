//
//  HqRichTextCell.m
//  HqUtils
//
//  Created by hehuiqi on 9/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqRichTextCell.h"

@implementation HqRichTextCell

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
        _firstImageView.clipsToBounds = YES;
        _firstImageView.contentMode = UIViewContentModeScaleToFill;
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    UIView *contentView = self;

    [contentView addSubview:self.contentLab];
    [contentView addSubview:self.firstImageView];
    [contentView addSubview:self.bottomView];
    self.imageIsLoaded = NO;
    [self hqLayout];
    
    
}
- (void)hqLayout{
    
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    CGFloat leftSpace = kZoomValue(15);
    CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
    UIView *contentView = self;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(leftSpace);
        make.top.equalTo(contentView).offset(leftSpace);
        make.width.mas_equalTo(contentW);
    }];
    
    [self.firstImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLab.mas_bottom).offset(leftSpace);
        make.left.equalTo(contentView).offset(leftSpace);
        make.height.mas_equalTo(kZoomValue(30));
        make.width.mas_equalTo(contentW);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImageView.mas_bottom).offset(leftSpace);
        make.left.equalTo(contentView).offset(leftSpace);
        make.width.mas_equalTo(contentW);
        make.height.mas_equalTo(kZoomValue(40));
        make.bottom.equalTo(contentView).offset(-leftSpace).priorityHigh();
    }];
}
- (void)setCellModel:(HqCellModel *)cellModel{
    _cellModel = cellModel;
    if (_cellModel) {
        
        if (cellModel.content.length>0) {
            
        }
        _contentLab.text = cellModel.content;
         
         CGFloat leftSpace = kZoomValue(15);
         CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
         NSURL *url = [NSURL URLWithString:cellModel.imageUrl];
         weakly(self);
        //加载过就不在加载
//         if (self.imageIsLoaded) {
//             return;
//         }
         [self.firstImageView sd_setImageWithURL:url  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
             NSLog(@"加载图片。。。");
             if (image) {
                 NSLog(@"加载图片完成");

                 CGFloat scaleH = image.size.height/image.size.width;
                 CGFloat imageH = contentW*scaleH;
                 CGFloat imageBottomSpace = leftSpace*2+kZoomValue(40);
                 UIView *contentView = self;
                 strongly(self);
                 [self.firstImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                     make.height.mas_equalTo(imageH);
                     make.bottom.equalTo(contentView).offset(-imageBottomSpace).priorityHigh();
                     [self setNeedsLayout];
                 }];
                
//                 self.imageIsLoaded = YES;
                 //加载完成通知列表在刷新一次
                 if (self.imageViweSizeChange) {
                     NSLog(@"imageViweSizeChange");
                     self.imageViweSizeChange();
                 }
             }
             
         }];
       
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"layoutSubviews---%@",NSStringFromCGRect(self.bounds));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
