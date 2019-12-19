//
//  HqChatNotifyCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatNotifyCell.h"

@implementation HqChatNotifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)notifyLab{
    if (!_notifyLab) {
        _notifyLab = [[UILabel alloc] init];
        _notifyLab.font = SetFont(12);
        _notifyLab.textColor = HqDeepGrayColor;
        _notifyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _notifyLab;
}
- (void)setup{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.notifyLab];
    [self.notifyLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)setMessage:(HqChatMessage *)message{
    
    self.notifyLab.text = message.content;
}
- (void)hqLayoutSubviews{
    
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
