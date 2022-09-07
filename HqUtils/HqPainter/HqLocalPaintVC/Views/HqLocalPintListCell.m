//
//  HqLocalPintListCell.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqLocalPintListCell.h"
#import "HqPaintFileManager.h"
@implementation HqLocalPintListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.hidden = YES;
        [self setup];
    }
    return self;
}
- (UILabel *)fileLab{
    if (!_fileLab) {
        _fileLab = [[UILabel alloc] init];
        _fileLab.font = SetFont(kZoomValue(16));
    }
    return _fileLab;
}
- (UIImageView *)fileIcon{
    if (!_fileIcon) {
        _fileIcon = [[UIImageView alloc] init];
        _fileIcon.backgroundColor = [UIColor lightGrayColor];
    }
    return _fileIcon;
}
- (void)setup{
    [self addSubview:self.fileIcon];
    [self addSubview:self.fileLab];
    [self hqLayoutSubviews];
}
- (void)hqLayoutSubviews{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat iconW = 60;
    CGFloat y = self.bounds.size.height - iconW;
    self.fileIcon.frame = CGRectMake(x, y, iconW, iconW);
    CGFloat labx = CGRectGetMaxX(self.fileIcon.frame)+10;
    CGFloat labw = self.bounds.size.width -labx - 15;
    self.fileLab.frame = CGRectMake(labx, 0, labw, self.bounds.size.height);
}
- (void)setFileName:(NSString *)fileName{
    _fileName = fileName;
    if (_fileName) {
        CAShapeLayer *layer = [HqPaintFileManager loadPaintFromFileName:fileName];
        self.paintLayer = layer;
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size,NO,0.0);
        [layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        self.fileIcon.image = image;
        self.fileLab.text = fileName;
    }
    
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
