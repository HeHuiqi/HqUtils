//
//  CHCodeView.m
//  Chainge
//
//  Created by Mac on 2020/12/8.
//

#import "CHCodeView.h"

@interface CHCodeView ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIView *cursor;

@end

@implementation CHCodeView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.userInteractionEnabled = NO;
    self.textColor = [UIColor blackColor];
    self.errorTextColor = [UIColor redColor];
    self.state = CHCodeStateNormal;
    self.style = CHCodeInputViewStyleText;
    
    _imageV = [[UIImageView alloc] init];
    _imageV.userInteractionEnabled = NO;
    [self addSubview:_imageV];
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont fontWithName:@"Heebo-Regular" size:30];
    _label.textColor = self.textColor;
    [self addSubview:_label];
    
    //默认关闭
    _showCursor = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    
    if (self.style == CHCodeInputViewStyleText) {
        self.imageV.mj_w = 44;
        self.normalImage = [UIImage imageNamed:@"inputshort"];
        self.selectedImage = [UIImage imageNamed:@"inputshort"];
        self.errorImage = [UIImage imageNamed:@"inputsw"];
        self.imageV.image = self.normalImage;
        self.label.textColor = self.textColor;
        
        if (self.text.length > 0  ) {
            self.imageV.image = self.selectedImage;
        }
        if (self.text.length > 0 && self.state  == CHCodeStateError ) {
            self.imageV.image = self.errorImage;
            self.label.textColor = self.errorTextColor;
        }
    }
    if (self.style == CHCodeInputViewStylePassword) {
        self.imageV.mj_w = 32;
        self.normalImage = [UIImage imageNamed:@"graycirl"];
        self.selectedImage = [UIImage imageNamed:@"bluecirl"];
        self.errorImage = [UIImage imageNamed:@"inputsw"];
        self.imageV.image = self.normalImage;
        self.label.textColor = self.textColor;
        if (self.text.length > 0  ) {
            self.imageV.image = self.selectedImage;
        }
        if (self.text.length > 0 && self.state  == CHCodeStateError ) {
            self.imageV.image = self.errorImage;
            self.label.textColor = self.errorTextColor;
        }
    }
    /*
    if (_text.length > 0) {
        if (self.bounds.size.width < 50) {
            
            if (self.bounds.size.height == 32) {
                self.imageV.image = [UIImage imageNamed:@"bluecirl"];
//                self.imageV.mj_w = 32;
            } else if (self.bounds.size.height == 16) {
                self.imageV.image = [UIImage imageNamed:@"numberItemsFilled"];
//                self.imageV.mj_w = 16;
            } else {
                self.imageV.image = [UIImage imageNamed:@"inputshort"];
                self.imageV.mj_w = 44;
                
                if ([_changeColor isEqualToString:@"red"]) {
                    self.imageV.image = [UIImage imageNamed:@"inputsw"];
                    self.label.textColor = [UIColor redColor];
                }
            }
        } else {
            
            if ([_changeColor isEqualToString:@"red"]) {
                self.imageV.image = [UIImage imageNamed:@"inputsw"];
                self.label.textColor = [UIColor redColor];
            } else if ([_changeColor isEqualToString:@"black"]) {
                self.imageV.image = [UIImage imageNamed:@"inputright"];
                self.label.textColor = [UIColor blackColor];
            } else {
                self.imageV.image = [UIImage imageNamed:@"inputright"];
            }
        }
    } else {
        if (self.bounds.size.width < 50) {
            
            if (self.bounds.size.height == 32) {
                self.imageV.image = [UIImage imageNamed:@"graycirl"];
//                self.imageV.mj_w = 32;
            } else if (self.bounds.size.height == 16) {
                self.imageV.image = [UIImage imageNamed:@"numberItemsEmpty"];
//                self.imageV.mj_w = 16;
            } else {
                self.imageV.image = [UIImage imageNamed:@"inputshort"];
                self.imageV.mj_w = 44;
            }
        } else {
            self.imageV.image = [UIImage imageNamed:@"inputright"];
        }
    }
    */
    
    
    
    CGFloat x = (self.frame.size.width - self.label.frame.size.width) / 2.0;
    CGFloat y = (self.frame.size.height - self.label.frame.size.height) / 2.0;
    self.label.frame = CGRectMake(x, y, self.label.frame.size.width, self.label.frame.size.height);
    
    [self updateCursorFrame];
}

- (void)setText:(NSString *)text {
    _text = text;
    _label.text = text;
    [self.label sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



- (void)setChangeColor:(NSString *)changeColor {
    _changeColor = changeColor;
    if ([changeColor isEqualToString:@"red"]) {
        self.imageV.image = [UIImage imageNamed:@"inputsw"];
        self.label.textColor = [UIColor redColor];
    } else if ([changeColor isEqualToString:@"blue"]) {
        self.imageV.image = [UIImage imageNamed:@"digitBgblue"];
        self.label.textColor = [UIColor blackColor];
    } else {
        self.label.textColor = [UIColor blackColor];
    }
            
    [self.label sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setState:(CHCodeState)state{
    _state = state;
    UIColor *textColor = state == CHCodeStateError ? self.errorTextColor: self.textColor;
    self.label.textColor = textColor;
    //触发布局更新
    [self setNeedsLayout];
}

- (void)updateCursorFrame {
    CGFloat x = 0;
    if (self.label.frame.size.width <= 0) {
        x = (self.frame.size.width - 1.6) / 2.0;
    } else {
        x = CGRectGetMaxX(self.label.frame);
    }
    _cursor.frame = CGRectMake(x, 10, 1.6, self.frame.size.height - 20);
}

- (void)setShowCursor:(BOOL)showCursor {
    
//    if (_showCursor == YES && showCursor == YES) { //重复开始, 那么,什么也不做
//    } else if (_showCursor == YES && showCursor == NO) { //原来是开始的, 现在要求关闭, 那么,就关闭
//        [_cursor removeFromSuperview];
//    } else if (_showCursor == NO && showCursor == YES) { //原来是关闭, 现在要求开始, 那么, 开始
//        _cursor = [[UIView alloc] init];
//        _cursor.userInteractionEnabled = NO;
//        _cursor.backgroundColor = UIColor.grayColor;
//        [self addSubview:_cursor];
//        [self updateCursorFrame];
//        _cursor.alpha = 0;
//        [self animationOne:_cursor];
//    } else if (_showCursor == NO && showCursor == NO) { //重复关闭
//        [_cursor removeFromSuperview];
//    }
//    _showCursor = showCursor;
    
    
    _showCursor = showCursor;
    [_cursor removeFromSuperview];
    if (_showCursor) {
        _cursor = [[UIView alloc] init];
        _cursor.userInteractionEnabled = NO;
        _cursor.backgroundColor = UIColor.grayColor;
        [self addSubview:_cursor];
        [self updateCursorFrame];
        _cursor.alpha = 0;
        [self animationOne:_cursor];
    }

}

// 光标效果
- (void)animationOne:(UIView *)aView {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        aView.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.showCursor) {
            [self performSelector:@selector(animationTwo:) withObject:aView afterDelay:0.5];
        }
    }];
}

- (void)animationTwo:(UIView *)aView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        aView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.showCursor) {
            [self performSelector:@selector(animationOne:) withObject:aView afterDelay:0.1];
        }
    }];
}

@end
