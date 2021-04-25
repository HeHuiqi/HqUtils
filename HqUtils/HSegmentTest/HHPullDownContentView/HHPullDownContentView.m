//
//  HHPullDownContentView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/2.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HHPullDownContentView.h"

@interface HHPullDownContentView ()<
UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView *tableBgView;

@end

@implementation HHPullDownContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.backgroundView = self.tableBgView;
    }
    return _tableView;
}
- (UIView *)tableBgView{
    if (!_tableBgView) {
        _tableBgView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableBgView;
}
- (void)setup{
    UIColor *bgColor = [UIColor blackColor];
    bgColor = [bgColor colorWithAlphaComponent:0.5];
    self.backgroundColor = bgColor;
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg)];
    [self.tableView.backgroundView addGestureRecognizer:tap];
    
    
    [self hqLayoutSuviews];
}

- (void)hqLayoutSuviews{

}
- (void)tapBg{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(hhPullDownContentView:selectedItem:)] && self.delegate) {
        [self.delegate hhPullDownContentView:self selectedItem:nil];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidden = YES;
    NSString *title = self.titles[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(hhPullDownContentView:selectedItem:)] && self.delegate) {
        [self.delegate hhPullDownContentView:self selectedItem:title];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.view isEqual:self.tableView]) {
            self.hidden = YES;
        }
    }];
}

@end
