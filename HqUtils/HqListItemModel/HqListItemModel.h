//
//  HqListItemModel.h
//  GlobalPay
//
//  Created by hqmac on 2019/3/5.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HqListItemModel : NSObject

@property (nonatomic,copy) NSString *hq_key;
@property (nonatomic,copy) NSString *hq_value;
@property (nonatomic,copy) NSString *hq_show_value;
@property (nonatomic,copy) NSString *hq_placeholder;
@property (nonatomic,copy) NSString *hq_url;
@property (nonatomic,copy) NSString *hq_icon_name;
@property (nonatomic,strong) UIImage  *hq_uploadImage;
@property (nonatomic,assign) NSInteger show_type;
@property (nonatomic,assign) NSInteger dataType;
@property (nonatomic,assign) NSInteger tag;

@property (nonatomic,assign) CGFloat cellHeight;


@property(nonatomic,assign) UIKeyboardType keyboardType;
@property(nonatomic,assign) BOOL secureTextEntry;

@property (nonatomic,assign) BOOL isSet;

+ (HqListItemModel *)item;

@end

NS_ASSUME_NONNULL_END
