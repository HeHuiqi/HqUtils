//
//  HqPassWordView.m

#import "HqPassWordView.h"

@interface HqPassWordView ()

@property (strong, nonatomic) NSMutableString *textStore;//保存密码的字符串

@end

@implementation HqPassWordView

static NSString  * const MONEYNUMBERS = @"0123456789";

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.style  = HqPassWordViewStyleDefault;
        self.textStore = [NSMutableString string];
        self.squareWidth = 46;
        self.passWordNum = 6;
        self.pointRadius = 10;
        self.isNeedBorder = YES;
        
        self.rectColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.pointColor = self.rectColor;
        
        self.normalImage = [UIImage imageNamed:@"num_normal"];
        self.selectedImage = [UIImage imageNamed:@"num_selected"];
        self.normalImageWidth = 28;
        self.selectedImageWidth = 26;
        //由用户触发吧
//        [self becomeFirstResponder];        
    }
    return self;
}

/**
 *  设置正方形的边长
 */
- (void)setSquareWidth:(CGFloat)squareWidth {
    _squareWidth = squareWidth;
    [self setNeedsDisplay];
}

/**
 *  设置键盘的类型
 */
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}
- (void)reInput{
    [self.textStore setString:@""];
    [self setNeedsLayout];
}
/**
 *  设置密码的位数
 */
- (void)setPassWordNum:(NSUInteger)passWordNum {
    _passWordNum = passWordNum;
    [self setNeedsDisplay];
}

- (BOOL)becomeFirstResponder {
    if ([self.delegate respondsToSelector:@selector(passWordBeginInput:)]) {
        [self.delegate passWordBeginInput:self];
    }
    return [super becomeFirstResponder];
}

/**
 *  是否能成为第一响应者
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark - UIKeyInputProtocol
/**
 *  用于显示的文本对象是否有任何文本
 */
- (BOOL)hasText {
    return self.textStore.length > 0;
}

/**
 *  插入文本
 */
- (void)insertText:(NSString *)text {
    if (self.textStore.length < self.passWordNum) {
        //判断是否是数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        if(basicTest) {
            [self.textStore appendString:text];
            if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.delegate passWordDidChange:self];
            }
            if (self.textStore.length == self.passWordNum) {
                [self resignFirstResponder];
                if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.delegate passWordCompleteInput:self];
                }
            }
            [self setNeedsDisplay];
        }
    }
}

/**
 *  删除文本
 */
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.delegate passWordDidChange:self];
        }
    }
    [self setNeedsDisplay];
}
#pragma mark - drawRect
// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    
    CGFloat height = rect.size.height;
    if (height > self.squareWidth) {
        height = self.squareWidth;
    }
    CGFloat width = rect.size.width;
    CGFloat x = 0.5;
    CGFloat y = 0.5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.isNeedBorder) {
        //画外框,一个长方框
        CGContextAddRect(context, CGRectMake( x, y, width-1.0,height-1.0));
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        //画中间的竖条，由此形成一个一个小格
//        NSLog(@"squareWidth:%@",@(self.squareWidth));
        for (int i = 1; i <= self.passWordNum; i++) {
            CGContextMoveToPoint(context, x+i*self.squareWidth, y);
            CGContextAddLineToPoint(context, x+i*self.squareWidth, y+self.squareWidth);
            CGContextClosePath(context);
        }
        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
    }
   
    switch (self.style) {
        case HqPassWordViewStyleImage:
        {
            //画数字占位图
            for (int i = 0; i < self.passWordNum; i++) {
                UIImage *image = self.normalImage;
                CGFloat imageW = self.normalImageWidth;
                CGFloat space = (self.squareWidth - imageW)/2.0;
                CGContextDrawImage(context, CGRectMake(x+space+i*self.squareWidth, y+(self.squareWidth-imageW)/2.0, imageW, imageW), image.CGImage);
            }
            
            //画输入后的的图
            for (int i = 0; i < self.textStore.length; i++) {
                UIImage *image = self.selectedImage;
                CGFloat imageW = self.selectedImageWidth;
                CGFloat space = (self.squareWidth - imageW)/2.0;
                CGContextDrawImage(context, CGRectMake(x+space+i*self.squareWidth, y+(self.squareWidth-imageW)/2.0, imageW, imageW), image.CGImage);
            }
        }
            break;
            
        default:
        {
            //画黑点
            for (int i = 0; i < self.textStore.length; i++) {
                CGFloat centeX = self.squareWidth/2.0;
                CGFloat centerY = self.squareWidth/2.0;
                CGContextAddArc(context,  x + centeX + i*self.squareWidth, y+centerY, self.pointRadius, 0, M_PI*2, YES);
                CGContextDrawPath(context, kCGPathFill);
            }
        }
            break;
    }
    [super drawRect:rect];
}

@end
