//
//  UITableView+CornerCell.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/25.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "UITableView+CornerCell.h"

#import <objc/message.h>

@implementation UITableView (CornerCell)


static char* kCellShowShadow;
- (void)setCellShowShadow:(BOOL)cellShowShadow{
    objc_setAssociatedObject(self, kCellShowShadow, @(cellShowShadow), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cellShowShadow{
    NSNumber *show =  objc_getAssociatedObject(self, kCellShowShadow);
    return show.boolValue;
}

- (void)tableViewCell:(UITableViewCell *)cell corneRadius:(CGFloat)corneRadius marginSpace:(CGFloat)marginSpace forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (corneRadius <=0 || marginSpace<=0) {
        return;
    }
    // 圆角角度
    CGFloat radius = corneRadius;
    // 设置cell 背景色为透明
    cell.backgroundColor = [UIColor clearColor];
    // 创建两个layer
    CAShapeLayer *normalLayer = [[CAShapeLayer alloc] init];
    CAShapeLayer *selectLayer = [[CAShapeLayer alloc] init];
    // 获取显示区域大小
    CGRect bounds = CGRectInset(cell.bounds, marginSpace, 0);

    // cell的backgroundView
    UIView *normalBgView = [[UIView alloc] initWithFrame:bounds];
    // 获取每组行数
    NSInteger rowNum = [self numberOfRowsInSection:indexPath.section];
    // 贝塞尔曲线
    UIBezierPath *bezierPath = nil;
    
    
    CGFloat shadowWidth = corneRadius/4.0;
    if (rowNum == 1) {
        // 一组只有一行（四个角全部为圆角）
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
        normalBgView.clipsToBounds = NO;
    } else {
        normalBgView.clipsToBounds = YES;
        if (indexPath.row == 0) {
            normalBgView.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(-shadowWidth, 0, 0, 0));
            CGRect rect = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(shadowWidth, 0, 0, 0));
            // 每组第一行（添加左上和右上的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(radius, radius)];
        } else if (indexPath.row == rowNum - 1) {
            normalBgView.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 0, -shadowWidth, 0));
            CGRect rect = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 0, shadowWidth, 0));
            // 每组最后一行（添加左下和右下的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(radius, radius)];
        } else {
            // 每组不是首位的行不设置圆角
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
    }
    
    // 阴影
    normalLayer.path = bezierPath.CGPath;
    if (self.cellShowShadow) {
        normalLayer.shadowColor = [UIColor blackColor].CGColor;
        normalLayer.shadowOpacity = 0.2;
        normalLayer.shadowOffset = CGSizeMake(0, 0);
        normalLayer.shadowPath = bezierPath.CGPath;
    }
    // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
    selectLayer.path = bezierPath.CGPath;
    
    // 设置填充颜色
    normalLayer.fillColor = [UIColor whiteColor].CGColor;
    // 添加图层到nomarBgView中
    [normalBgView.layer insertSublayer:normalLayer atIndex:0];
    normalBgView.backgroundColor = UIColor.clearColor;
    cell.backgroundView = normalBgView;
    
    //替换cell点击效果
    UIView *selectBgView = [[UIView alloc] initWithFrame:bounds];
    selectLayer.fillColor = [UIColor colorWithWhite:0.95 alpha:1.0].CGColor;
    [selectBgView.layer insertSublayer:selectLayer atIndex:0];
    selectBgView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectBgView;
}

@end
