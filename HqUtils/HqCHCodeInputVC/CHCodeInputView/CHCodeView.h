//
//  CHCodeView.h
//  Chainge
//
//  Created by Mac on 2020/12/8.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CHCodeInputViewStyle) {
    CHCodeInputViewStyleText,
    CHCodeInputViewStylePassword,

};

typedef NS_ENUM(NSUInteger, CHCodeState) {
    CHCodeStateNormal,
    CHCodeStateError,
};

NS_ASSUME_NONNULL_BEGIN

@interface CHCodeView : UIView

// 文字
@property (nonatomic, strong) NSString *text;

// 显示光标 默认关闭
@property (nonatomic) BOOL showCursor;

// 改变颜色
@property (nonatomic, strong) NSString *changeColor;

@property (nonatomic, assign) BOOL hideText;


@property(nonatomic,assign) CHCodeInputViewStyle style;
@property(nonatomic,assign) CHCodeState state;

@property(nonatomic,strong) UIImage *normalImage;
@property(nonatomic,strong) UIImage *selectedImage;
@property(nonatomic,strong) UIImage *errorImage;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *errorTextColor;


@end

NS_ASSUME_NONNULL_END
