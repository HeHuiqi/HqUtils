//
//  HqRichTextCell.m
//  HqUtils
//
//  Created by hehuiqi on 9/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqRichTextCell.h"

@interface HqRichTextCell ()

@property(nonatomic,assign) CGSize imageSize;

@end

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
- (HqRichTextContentView *)richTextContentView{
    if (!_richTextContentView) {
        _richTextContentView = [[HqRichTextContentView alloc] init];
    }
    return _richTextContentView;
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

    [contentView addSubview:self.richTextContentView];
    
    [self.richTextContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    
}

- (void)setCellModel:(HqCellModel *)cellModel{
    _cellModel = cellModel;
    if (_cellModel) {
        self.richTextContentView.cellModel = cellModel;
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
