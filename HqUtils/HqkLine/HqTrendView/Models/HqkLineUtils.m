//
//  HqkLineUtils.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/9.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqkLineUtils.h"

@implementation HqkLineUtils

+ (HqklineShowModel *)dealKlineDatas:(NSArray *)datas showViewHeight:(CGFloat)viewHeight{
    
    if (datas.count==0) {
        return nil;
    }
    HqklineShowModel *showModel = [[HqklineShowModel alloc] init];
    NSMutableArray *kLineModels = [[NSMutableArray alloc] init];
    CGFloat maxPrice = 0;
    CGFloat minPrice = 0;
    NSInteger index = 0;
    for (NSDictionary *dic  in datas) {
        HqkLineModel *kLineModel = [HqkLineModel mj_objectWithKeyValues:dic];
        [kLineModels addObject:kLineModel];
        if (index == 0) {
            minPrice = kLineModel.close;
        }
        index ++;
        if (kLineModel.close>maxPrice) {
            maxPrice = kLineModel.close;
        }
        if (minPrice>kLineModel.close) {
            minPrice = kLineModel.close;
        }
    }
    CGFloat offset = (maxPrice-minPrice);
    if (offset==0) {
        offset = 1;
    }
    CGFloat scaleY = viewHeight/offset;
//    NSLog(@"scaleY==%@,maxPrice==%@,minPrice==%@",@(scaleY),@(maxPrice),@(minPrice));
    if (maxPrice>0 && minPrice>-1) {
        NSMutableArray *pointModels = [[NSMutableArray alloc] init];
        CGFloat contentW = SCREEN_WIDTH - kZoomValue(84);
        CGFloat plus = contentW/kLineModels.count;
        for (int i=0; i<kLineModels.count; i++) {
            HqkLineModel *kLineModel = kLineModels[i];
            CGFloat pointY = (maxPrice-kLineModel.close)*scaleY;
            HqPointModel *pointModel = [[HqPointModel alloc] init];
            pointModel.xPosition = i*plus;
            pointModel.yPosition = pointY;
            [pointModels addObject:pointModel];
//            NSLog(@"pointModel==%@",pointModel);
            pointModel.kLinemodel = kLineModel;
        }
        showModel.maxPrice = maxPrice;
        showModel.minPrice = minPrice;
        showModel.showPointArray = pointModels;

    }
    
    return showModel;
}

@end
