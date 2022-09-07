//
//  HqPassWordView.h


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HqPassWordViewStyleDefault,
    HqPassWordViewStyleImage,
} HqPassWordViewStyle;
@class HqPassWordView;

@protocol  HqPassWordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(HqPassWordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(HqPassWordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(HqPassWordView *)passWord;


@end

IB_DESIGNABLE

@interface HqPassWordView : UIView<UIKeyInput>

@property(nonatomic,assign) HqPassWordViewStyle style; //默认 HqPassWordViewStyleDefault
@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;//密码的位数
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;//正方形的大小
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;//黑点的半径
@property (strong, nonatomic) IBInspectable UIColor *pointColor;//黑点的颜色
@property (strong, nonatomic) IBInspectable UIColor *rectColor;//边框的颜色
@property(nonatomic,assign) BOOL isNeedBorder;
@property (weak, nonatomic) IBOutlet id<HqPassWordViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串

//以下属性仅为style 是 HqPassWordViewStyleImage 而自定义
//图片的宽高比须相同，否则会显示变形
//几个属性根据自己的图片和方框大小按实际调整
@property(nonatomic,strong) UIImage *normalImage;
@property(nonatomic,assign) CGFloat normalImageWidth;
@property(nonatomic,strong) UIImage *selectedImage;
@property(nonatomic,assign) CGFloat selectedImageWidth;


//重新输入，清除
- (void)reInput;
@end
