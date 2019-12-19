//
//  HqTextView.h
//  HqUtils
//
//  Created by hehuiqi on 9/28/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kATFormat  @"@%@ "
#define kATRegular @"@[\\u4e00-\\u9fa5\\w\\-\\_]+ "
//#define kATRegular @"@[\\uD83C[\\uDF00-\\uDFFF]|\\uD83D[\\uDC00-\\uDE4F]|\\u4e00-\\u9fa5\\w\\-\\_]+ "

NS_ASSUME_NONNULL_BEGIN
@protocol HqTextViewDelegate;
@interface HqTextView : UITextView<UITextViewDelegate>

@property(nonatomic,weak) id<HqTextViewDelegate> hqDelegate;
@property(nonatomic,strong) NSMutableDictionary *atInfos;


- (NSString *)converToPreviewFormat:(NSString *)text;

//插入@
- (void)inserAtStr:(NSString *)atStr;


@end

@protocol HqTextViewDelegate <NSObject>

@optional
- (void)hqTextViewDidInputAt:(HqTextView *)textView;
- (void)hqTextViewDidChange:(HqTextView *)textView;

@end

NS_ASSUME_NONNULL_END
