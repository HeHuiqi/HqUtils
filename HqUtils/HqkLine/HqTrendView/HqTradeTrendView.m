//
//  HqTradeTrendView.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import "HqTradeTrendView.h"
@interface HqTradeTrendView()<HqFoldLineViewDelegate>

@property(nonatomic,strong) UILabel *touchShowPriceLab;
@property(nonatomic,strong) UILabel *touchShowDateLab;

@end

@implementation HqTradeTrendView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (UISegmentedControl *)segmentControl{
    if (!_segmentControl) {
        NSArray *itemTitles = @[@"全部",@"24小时",@"7天",@"30天",@"一年"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:itemTitles];
        _segmentControl.selectedSegmentIndex = 0;
    }
    
    return _segmentControl;
}
- (HqYCoordinateView *)yCoordinateView{
    if (!_yCoordinateView) {
        _yCoordinateView = [[HqYCoordinateView alloc] init];
    }
    return _yCoordinateView;
}
- (UILabel *)touchShowPriceLab{
    if (!_touchShowPriceLab) {
        _touchShowPriceLab = [[UILabel alloc] init];
        _touchShowPriceLab.textColor = [UIColor blueColor];
        _touchShowPriceLab.hidden = YES;
        _touchShowPriceLab.font = SetFont(kZoomValue(13));
        _touchShowPriceLab.lineBreakMode = NSLineBreakByClipping;
        _touchShowPriceLab.backgroundColor = [UIColor whiteColor];
    }
    return _touchShowPriceLab;
}
- (UILabel *)touchShowDateLab{
    if (!_touchShowDateLab) {
        _touchShowDateLab = [[UILabel alloc] init];
        _touchShowDateLab.textColor = [UIColor blueColor];
        _touchShowDateLab.hidden = YES;
        _touchShowDateLab.font = SetFont(kZoomValue(13));
        _touchShowDateLab.lineBreakMode = NSLineBreakByClipping;
        _touchShowDateLab.backgroundColor = [UIColor whiteColor];
        _touchShowDateLab.text = @"日期";
    }
    return _touchShowDateLab;
}
- (HqFoldLineView *)foldLineView{
    if (!_foldLineView) {
        _foldLineView = [[HqFoldLineView alloc] init];
        _foldLineView.delegate = self;
    }
    
    return _foldLineView;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}
- (UILabel *)startDateLab{
    if (!_startDateLab) {
        _startDateLab = [[UILabel alloc] init];
        _startDateLab.font = SetFont(kZoomValue(12));
    }
    return _startDateLab;
}
- (UILabel *)endDateLab{
    if (!_endDateLab) {
        _endDateLab = [[UILabel alloc] init];
        _endDateLab.font = SetFont(kZoomValue(12));
    }
    return _endDateLab;
}
- (void)setup{
    [self addSubview:self.topView];
    [self.topView addSubview:self.segmentControl];
    [self addSubview:self.foldLineView];
    [self addSubview:self.yCoordinateView];
    [self addSubview:self.startDateLab];
    [self addSubview:self.endDateLab];
    [self addSubview:self.touchShowPriceLab];
    [self addSubview:self.touchShowDateLab];
    
    
    [self hqLayoutSubviews];
}
- (void)hqLayoutSubviews{
    
    CGFloat leftSpace = kZoomValue(12);
    CGFloat contentW = SCREEN_WIDTH - leftSpace*2;
//    self.topView.backgroundColor = HqRandomColor;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self).offset(0);
         make.top.equalTo(self).offset(0);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kZoomValue(60)));
     }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.centerX.equalTo(self.topView);
        make.width.mas_equalTo(contentW);
        make.height.mas_equalTo(30);
    }];
    CGFloat yCoordinateW = kZoomValue(60);
    CGFloat lineViewW = contentW - yCoordinateW;
    CGFloat lineViewH = kZoomValue(200);
    
    
    [self.foldLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftSpace);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(lineViewW,lineViewH));
    }];
    [self.yCoordinateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-leftSpace);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(yCoordinateW,lineViewH));
    }];
    [self.startDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foldLineView.mas_left);
        make.top.equalTo(self.foldLineView.mas_bottom).offset(0);
        make.height.mas_equalTo(kZoomValue(20));
    }];
    [self.endDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.foldLineView.mas_right);
        make.top.equalTo(self.foldLineView.mas_bottom).offset(0);
        make.height.mas_equalTo(kZoomValue(20));
    }];
    [self.touchShowPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yCoordinateView.mas_left);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
    }];
    [self.touchShowDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startDateLab.mas_left).offset(0);
        make.top.equalTo(self.foldLineView.mas_bottom).offset(0);
        make.height.mas_equalTo(kZoomValue(20));
    }];
    self.startDateLab.text = @"开始";
    self.endDateLab.text = @"结束";
}
#pragma mark - HqFoldLineViewDelegate
- (void)hqFoldLineView:(HqFoldLineView *)view touchBeginShowPointModel:(HqPointModel *)touchModel{
    self.touchShowPriceLab.hidden = NO;
    self.touchShowDateLab.hidden = NO;
    
    [self.touchShowPriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(touchModel.yPosition-8);
    }];
    [self.touchShowDateLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startDateLab.mas_left).offset(touchModel.xPosition);
    }];
    
    self.touchShowPriceLab.text =  [NSString stringWithFormat:@"%@",@(touchModel.kLinemodel.close)];
    self.touchShowDateLab.text =  [self formatDate:touchModel.kLinemodel.datetime];

}
- (NSString *)formatDate:(NSString *)dateStr{
    NSString *restultStr = @"MM-dd HH:mm";
    if (self.segmentControl.selectedSegmentIndex ==0 ||
        self.segmentControl.selectedSegmentIndex == 4) {
        restultStr = @"yyyy-MM-dd";
    }
   return  [HqDateFormatter convertDateString:dateStr orginalFormat:@"yyyy-MM-dd HH:mm:ss" resultFormat:restultStr];
}
- (void)hqFoldLineViewTouchEndDismiss:(HqFoldLineView *)view{
    self.touchShowPriceLab.hidden = YES;
    self.touchShowDateLab.hidden = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    CGFloat priceLabX = SCREEN_WIDTH - kZoomValue(84);
//    self.touchShowPriceLab.frame = CGRectMake(priceLabX, 0, kZoomValue(60), 12);
}
- (NSString *)formatDate2:(NSString *)dateStr{
   return  [HqDateFormatter convertDateString:dateStr orginalFormat:@"yyyy-MM-dd HH:mm:ss" resultFormat:@"yyyy-MM-dd HH:mm"];
}
- (void)setKlineShowModel:(HqklineShowModel *)klineShowModel{
    _klineShowModel = klineShowModel;
    if (_klineShowModel) {
        NSArray *points =  klineShowModel.showPointArray;
        self.foldLineView.datas = points;
        HqPointModel *firstModel = points.firstObject;
        HqPointModel *lastModel = points.lastObject;
        self.startDateLab.text = [self formatDate2:firstModel.kLinemodel.datetime];
        self.endDateLab.text = [self formatDate2:lastModel.kLinemodel.datetime];
        CGFloat priceOffset = (klineShowModel.maxPrice-klineShowModel.minPrice)/3.0;
        CGFloat secondPrice = klineShowModel.minPrice+priceOffset;
        CGFloat threePrice = klineShowModel.minPrice+priceOffset*2;

        NSArray *prices = @[@(klineShowModel.maxPrice).stringValue,
                            @(threePrice).stringValue,
                            @(secondPrice).stringValue,
                            @(klineShowModel.minPrice).stringValue,];
        self.yCoordinateView.datas = prices;
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
