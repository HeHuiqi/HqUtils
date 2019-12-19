//
//  HqCoreTextVC.m
//  HqUtils
//
//  Created by hehuiqi on 8/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCoreTextVC.h"
#import "HqCoreTextView.h"

@interface HqCoreTextVC ()

@property (nonatomic,strong) HqCoreTextView *drawView;
@property (nonatomic,strong) HqCoreTextView *drawLineView;
@property (nonatomic,strong) UILabel *showLab;



@end

@implementation HqCoreTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    NSString *theLanguage = [[UITextChecker availableLanguages] objectAtIndex:0];

    [self.view addSubview:self.drawView];
//    [self.view addSubview:self.drawLineView];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.showLab];
    //判断是否超过三行超过三行，获取第二行的range,根据range获取子串，字串去掉几个字符，加上...更多》
    self.showLab.text = @"还是快点好噶深刻的感受都会开始噶说的还是快点好噶深刻的感受都会开始噶说的还是快点好噶深刻的感受都会开始噶说的还是快点好噶深刻的感受都会开始噶说的还是快点好噶深刻的感受都会开始噶说的";
    NSLog(@"showtext == %@",self.showLab.text);
    NSLog(@"lineBreakMode == %@",@(self.showLab.lineBreakMode));
//    - (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
    CGRect rect = [self.showLab textRectForBounds:CGRectMake(0, 0, self.showLab.bounds.size.width, self.showLab.font.lineHeight*2) limitedToNumberOfLines:4];
    NSLog(@"rect == %@",NSStringFromCGRect(rect));
    
    UIButton *btn = [[UIButton alloc] initWithFrame:self.showLab.frame];
//    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    btn.backgroundColor = HqRandomColor;
    [btn setTitle:self.showLab.text forState:UIControlStateNormal];
    [self.view addSubview:btn];
//    topic_organizer_small_icon
    
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];

    
    NSAttributedString *pretext = [[NSAttributedString alloc] initWithString:@"来自"];
    [textAttrStr appendAttributedString:pretext];

    NSTextAttachment *iconAttach = [[NSTextAttachment alloc] init];
    iconAttach.image = [UIImage imageNamed:@"topic_organizer_small_icon"];
    iconAttach.bounds = CGRectMake(0,-2,12,12);
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:iconAttach];
    [textAttrStr appendAttributedString:imgStr];
    
    NSAttributedString *endtext = [[NSAttributedString alloc] initWithString:@"我的家" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    [textAttrStr appendAttributedString:endtext];
    
//      NSBaselineOffsetAttributeName:@(([UIFont systemFontOfSize:30].lineHeight - [UIFont systemFontOfSize:15].lineHeight)/2 + (([UIFont systemFontOfSize:30].descender - [UIFont systemFontOfSize:15].descender))),
//    [textAttrStr addAttribute:NSBaselineOffsetAttributeName value:@(([UIFont systemFontOfSize:30].lineHeight - [UIFont systemFontOfSize:15].lineHeight)/2 + (([UIFont systemFontOfSize:30].descender - [UIFont systemFontOfSize:15].descender))) range:NSMakeRange(0, textAttrStr.length)];
    
    UILabel *org = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.drawView.frame), self.view.bounds.size.width-30, 100)];
    org.font = SetFont(13);
    [self.view addSubview:org];
    org.attributedText = textAttrStr;
    
    
    
}
- (UILabel *)showLab{
    if (!_showLab) {
        _showLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 100)];
        _showLab.backgroundColor = HqRandomColor;
        _showLab.numberOfLines = 3;
    }
    return _showLab;
}
- (HqCoreTextView *)drawLineView{
    if (!_drawLineView) {
        CGFloat y = CGRectGetMaxY(self.drawView.frame)+20;
        _drawLineView = [[HqCoreTextView alloc] initWithFrame:CGRectMake(20, y, 300, 300)];
        _drawLineView.drawWay = 0;
        _drawLineView.backgroundColor = HqRandomColor;
    }
    return _drawLineView;
}

- (HqCoreTextView *)drawView{
    if (!_drawView) {
        _drawView = [[HqCoreTextView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
        _drawView.drawWay = 1;
        _drawView.backgroundColor = HqRandomColor;
    }
    return _drawView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
