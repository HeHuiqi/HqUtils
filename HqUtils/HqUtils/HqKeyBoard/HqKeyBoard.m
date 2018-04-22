//
//  HqKeyBoard.m
//  HqCustomKeyBorder
//
//  Created by macpro on 2018/2/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqKeyBoard.h"
#define HqLineWidth 1.0/([UIScreen mainScreen].scale)

@interface HqKeyBoard()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *lines;

@end
@implementation HqKeyBoard
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        self.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220);
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    _btns = [[NSMutableArray alloc] initWithCapacity:0];
    _lines = [[NSMutableArray alloc] initWithCapacity:0];
    self.titles = @[@"1",@"2",@"3",@"<",@"4",@"5",@"6",@" ",@"7",@"8",@"9",@"完成",@".",@"0",@"取消",@""];
    
}
- (void)setTf:(UITextField *)tf{
    _tf = tf;
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles) {
        for (UIView *view  in self.subviews) {
            [view removeFromSuperview];
        }
        [_btns removeAllObjects];
        for (int i = 0; i<_titles.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            btn.tag = i;
            [_btns addObject:btn];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
           
            [self addSubview:btn];
            if (btn.tag == 11) {
                btn.tintColor = HqDoneBtnTitleColor;
                btn.backgroundColor = HqDoneBtnBgColor;
                btn.titleLabel.font = [UIFont systemFontOfSize:20.0];
            }else{
                btn.tintColor = HqBtnTitleColor;
                btn.titleLabel.font =[UIFont systemFontOfSize:HqNumberSize];
            }
            UIImage *image = [self createImageWithColor:HqLineColor];
            [btn setBackgroundImage:image forState:UIControlStateHighlighted];
        }
        for (int i = 0; i<7; i++) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = HqLineColor;
            [_lines addObject:line];
            [self addSubview:line];
        }
        [self setNeedsDisplay];
    }
}
- (void)setCancelImage:(UIImage *)cancelImage{
    _cancelImage = cancelImage;
    if (_cancelImage) {
        UIButton *btn = _btns[14];
        [btn setTitle:nil forState:UIControlStateNormal];
        [btn setImage:_cancelImage forState:UIControlStateNormal];
    }
}
- (void)setDeleteImage:(UIImage *)deleteImage{
    _deleteImage = deleteImage;
    if (_deleteImage) {
        UIButton *btn = _btns[3];
        [btn setTitle:nil forState:UIControlStateNormal];
        [btn setImage:_deleteImage forState:UIControlStateNormal];
    }
}
- (void)layoutSubviews{
    CGFloat height = self.bounds.size.height/4.0;
    CGFloat width = self.bounds.size.width/4.0;
    for (int i = 0; i<_btns.count; i++) {
        UIButton *btn = _btns[i];
        CGFloat x = (i%4)*width;
        CGFloat y = (i/4)*height;
        if (btn.tag == 7|| btn.tag == 15) {
            btn.hidden = YES;
        }
        if (btn.tag == 3||btn.tag == 11) {
            btn.frame = CGRectMake(x, y, width, height*2);
        }else{
            btn.frame = CGRectMake(x, y, width, height);
        }
        
    }
    for (int i = 0; i<_lines.count; i++) {
        UIView *line = _lines[i];
        CGFloat x = 0.0;
        CGFloat y = 0;
        CGFloat lineWidth = 0.0;
        CGFloat lineHeight = 0.0;
        if (i<4) {
            x = 0;
            lineWidth = self.bounds.size.width - width;
            if (i == 0 | i == 2) {
                lineWidth = self.bounds.size.width;
            }
            y = i*height;
            lineHeight = HqLineWidth;
        }else{
            x = (i%4+1)*width;
            y = 0;
            lineWidth = HqLineWidth;
            lineHeight = self.bounds.size.height;
        }
        line.frame = CGRectMake(x, y, lineWidth, lineHeight);
    }
    [super layoutSubviews];
}

- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = _tf.beginningOfDocument;
    UITextPosition* startPosition = [_tf positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [_tf positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [_tf textRangeFromPosition:startPosition toPosition:endPosition];
    [_tf setSelectedTextRange:selectionRange];
}
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 3:
            {
                if (_tf.text.length>=1) {
                    UITextPosition *positon = _tf.beginningOfDocument;
                    
                    //开始位置
                    UITextPosition* beginning = _tf.beginningOfDocument;
                    //光标选择区域
                    UITextRange* selectedRange = _tf.selectedTextRange;
                    //选择的开始位置
                    UITextPosition* selectionStart = selectedRange.start;
                    //选择的结束位置
                    UITextPosition* selectionEnd = selectedRange.end;
                    //选择的实际位置
                    const NSInteger location = [_tf offsetFromPosition:beginning toPosition:selectionStart];
                    
                    _tf.text = [_tf.text substringToIndex:_tf.text.length-1];
//                    NSString *last = [_tf.text substringWithRange:NSMakeRange(location, _tf.text.length-location)];
//                    NSString *header = [_tf.text substringWithRange:NSMakeRange(0, location-1)];
//                    _tf.text = [NSString stringWithFormat:@"%@%@",header,last];
//                    [self setSelectedRange:NSMakeRange(location-1, _tf.text.length-location-1)];
                }
            }
            break;
        case 11:
        {
            [_tf resignFirstResponder];
        }
            break;
        case 14:
        {
            [_tf resignFirstResponder];
        }
            break;
            
        default:
        {
            _tf.text = [NSString stringWithFormat:@"%@%@",_tf.text,btn.titleLabel.text];

        }
            break;
    }
}
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
