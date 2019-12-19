//
//  HqTimeLineCell.m
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTimeLineCell.h"

@implementation HqTimeLineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (UIImageView *)smallImageView{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] init];
        _smallImageView.contentMode = UIViewContentModeScaleAspectFill;
        _smallImageView.clipsToBounds = YES;
        _smallImageView.userInteractionEnabled = YES;
        _smallImageView.backgroundColor = [UIColor blueColor];
        UIImage *image = [UIImage imageNamed:@"yazi.jpeg"];
        _smallImageView.image = image;
    }
    return _smallImageView;
}
- (void)setup{
    [self addSubview:self.smallImageView];
//    self.smallImageView.frame = CGRectMake(15, 10, 170, 170);
    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(170, 170));
    }];
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
