//
//  HqTestCell.m
//  HqUtils
//
//  Created by hehuiqi on 7/3/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTestCell.h"

@implementation HqTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = HqRandomColor;
    for (int i = 0; i<3; i++) {
        UIImage *cornerImage = [UIImage imageNamed:@"longmao.jpeg"];
        HqSetCornerView *showImageView = [[HqSetCornerView alloc] init];
//        showImageView.image = cornerImage;
        [self addSubview:showImageView];
        showImageView.hqCornerRadius = 50;
        [showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15+i*115);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [showImageView sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/8843659-e2ed03e5ffea9463.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/759"] placeholderImage:cornerImage];

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
