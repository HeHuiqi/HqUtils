//
//  CHCodeInputView.h
//  Chainge
//
//  Created by Mac on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "CHCodeView.h"

NS_ASSUME_NONNULL_BEGIN



@interface CHCodeInputView : UIView

typedef void(^changeState)(void);

//验证码文字
@property (strong, nonatomic) NSString *codeText;

@property (strong, nonatomic) NSString *passtext;

//设置验证码位数 默认 4 位
@property (nonatomic) NSInteger codeCount;

//验证码数字之间的间距 默认 35
@property (nonatomic) CGFloat codeSpace;

@property (nonatomic, assign) BOOL hideText;

- (void)changeTextState:(changeState)state;

@property (nonatomic, strong) NSString *textChangeColor;

@property (nonatomic, copy) changeState finishState;

@property (nonatomic, strong) NSString *textEmpty;

@property (nonatomic, strong) UIColor *color;

@property(nonatomic,assign) CHCodeInputViewStyle style;
@property(nonatomic,assign) CHCodeState state;


@end

NS_ASSUME_NONNULL_END
