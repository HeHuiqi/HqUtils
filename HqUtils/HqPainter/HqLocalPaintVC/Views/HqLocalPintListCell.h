//
//  HqLocalPintListCell.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqLocalPintListCell : UITableViewCell

@property(nonatomic,strong) UIImageView *fileIcon;
@property(nonatomic,strong) UILabel *fileLab;
@property(nonatomic,strong) NSString *fileName;
@property(nonatomic,strong) CAShapeLayer *paintLayer;

@end

NS_ASSUME_NONNULL_END
