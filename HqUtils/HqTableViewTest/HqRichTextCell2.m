//
//  HqRichTextCell.m
//  HqUtils
//
//  Created by hehuiqi on 10/12/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqRichTextCell2.h"
#import "RegexKitLite.h"
#import <YYText/NSAttributedString+YYText.h>
@implementation HqRichTextCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _userIcon = [[UIImageView alloc] init];
    _userIcon.backgroundColor = HqRandomColor;

    [self addSubview:_userIcon];
    
    _contentTv = [[UITextView alloc] init];
    _contentTv.editable = NO;
    _contentTv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _contentTv.dataDetectorTypes = UIDataDetectorTypeLink;
    _contentTv.font = SetFont(17);
//    _contentTv.selectable = NO;
    _contentTv.textContainer.maximumNumberOfLines = 0;
    _contentTv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    _contentTv.delegate = self;
    _contentTv.scrollEnabled = NO;
    [self addSubview:_contentTv];

    _contentLab = [[YYLabel alloc] init];
    _contentLab.numberOfLines = 6;
    _contentLab.font = SetFont(16);
    [self addSubview:_contentLab];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = HqRandomColor;
    [self addSubview:_bottomView];
    [self hqLayoutSubView];
}
- (void)hqLayoutSubView{
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    _contentTv.backgroundColor = [UIColor redColor];
    [_contentTv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.top.equalTo(self).offset(15);
//        make.height.mas_equalTo(100);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-40);
    }];
    
//    _contentLab.preferredMaxLayoutWidth = SCREEN_WIDTH - 70;
//      [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.userIcon.mas_right).offset(10);
//            make.top.equalTo(self.userIcon);
//    //        make.height.mas_equalTo(100);
//            make.right.equalTo(self).offset(-15);
//            make.bottom.equalTo(self).offset(-40);
//        }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon).offset(10);
        make.bottom.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
}
- (void)setContent:(NSString *)content{
    _content = content;
    if (_content) {
        // url正则有很多种，不过这个已经够满足我的需求
        /*
        NSString *labelText = content;
        NSString *regex_http = @"<a href=(?:.*?)>(.*?)<\\/a>";
        NSString *a_href = @"href='(.*?)'";
        NSArray *array_http = [labelText arrayOfCaptureComponentsMatchedByRegex:regex_http];
        NSLog(@"array_http=%@",array_http);
        // 先把html a标签都给去掉
              labelText = [labelText stringByReplacingOccurrencesOfString:@"<a href=(.*?)>"
                                                                       withString:@""
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange (0, labelText.length)];
              labelText = [labelText stringByReplacingOccurrencesOfString:@"<\\/a>"
                                                                       withString:@""
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange (0, labelText.length)];
          NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString: labelText];

//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
//           [text yy_setFont:[UIFont systemFontOfSize:20] range:text.yy_rangeOfAll];//字体
//           text.yy_lineSpacing = 20;//行间距
//
        for (NSArray *array in array_http) {
            // 获得链接显示文字的range，用来设置下划线
            NSRange range = [labelText rangeOfString:array[1]];
//            NSLog(@"array[0]==%@",array[0]);
            NSString *result  = [array[0] stringByMatching:a_href];
            result = [result substringWithRange:NSMakeRange(6, result.length-7)];
            NSLog(@"result==%@",result);

            
//            [one addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
            [one addAttribute:NSLinkAttributeName value:result range:range];
            
            YYTextHighlight *hi = [YYTextHighlight new];
             [one setTextHighlight:hi range:range];
            [one setTextHighlightRange:range color:[UIColor blueColor] backgroundColor:[UIColor lightGrayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                //点击展开
                NSLog(@"range==%@",NSStringFromRange(range));
               NSString *atStr =  [text.string substringWithRange:range];
                NSLog(@"atStr==%@",atStr);
                [text enumerateAttribute:NSLinkAttributeName inRange:range options:(NSAttributedStringEnumerationReverse) usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
                    NSLog(@"link_value==%@",value);
                }];
            }];
        }
  
        
//        NSAttributedString *atrs = [self htmlConvertStringRemoveImgTag:content];
        [one addAttribute:NSFontAttributeName value:_contentLab.font range:NSMakeRange(0, one.length)];
        */
//        self.contentTv.attributedText = one;
        //添加点击事件
        NSAttributedString *atrs = [self dealContentTagWithText:content font:_contentLab.font lineSpace:0 didClickLink:^(NSString *url) {
//            NSLog(@"url==%@",url);
            [Dialog simpleToast:url];

        }];
//        self.contentLab.attributedText = atrs;
        self.contentTv.attributedText = atrs;

    }
}

- (NSAttributedString *)dealContentTagWithText:(NSString *)labelText font:(UIFont *)font lineSpace:(CGFloat)lineSpace didClickLink:(void(^)(NSString *url))didClickLink{

    NSString *regex_http = @"<a href=(?:.*?)>(.*?)<\\/a>";
    NSArray *atags = [labelText arrayOfCaptureComponentsMatchedByRegex:regex_http];
//    NSLog(@"array_http=%@",array_http);
    // 先把html a标签都给去掉
    labelText = [labelText stringByReplacingOccurrencesOfString:@"<a href=(.*?)>"
                                                                   withString:@""
                                                                      options:NSRegularExpressionSearch
                                                                        range:NSMakeRange (0, labelText.length)];
    labelText = [labelText stringByReplacingOccurrencesOfString:@"<\\/a>"
                                                                   withString:@""
                                                                      options:NSRegularExpressionSearch
                                                                        range:NSMakeRange (0, labelText.length)];
    
    NSMutableAttributedString *resultAtrs = [[NSMutableAttributedString alloc] initWithString: labelText];
    [resultAtrs addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, resultAtrs.length)];
    if (lineSpace>0) {
        resultAtrs.yy_lineSpacing = lineSpace;
    }
    [self addAllAtTagAttributeString:resultAtrs onlyText:labelText aTags:atags didClickLink:didClickLink];
    
    
    return resultAtrs;
}
- (void)addAllAtTagAttributeString:(NSMutableAttributedString *)atrs onlyText:(NSString *)onlyText aTags:(NSArray *)atags didClickLink:(void(^)(NSString *url))didClickLink{
    NSString *a_href = @"href='(.*?)'";
    for (NSArray *array in atags) {
        // 获得链接显示文字的range
        NSRange range = [onlyText rangeOfString:array[1]];
        NSString *result  = [array[0] stringByMatching:a_href];
        result = [result substringWithRange:NSMakeRange(6, result.length-7)];
        [atrs addAttribute:NSLinkAttributeName value:result range:range];
//        [self addTagLinkWithAttributeString:atrs range:range didClickLink:didClickLink];
    }
}
- (void)addTagLinkWithAttributeString:(NSMutableAttributedString *)atrs range:(NSRange)range didClickLink:(void(^)(NSString *url))didClickLink{
    [atrs yy_setTextHighlightRange:range color:[UIColor blueColor] backgroundColor:[UIColor lightGrayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         [text enumerateAttribute:NSLinkAttributeName inRange:range options:(NSAttributedStringEnumerationReverse) usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
             NSLog(@"link_value==%@",value);
             didClickLink(value);
         }];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    NSLog(@"textAttachment==%@",textAttachment);

    return YES;
}
#pragma mark - html字符串转文本
- (NSAttributedString *)htmlConvertStringRemoveImgTag:(NSString *)noImgTagHtmlStr{
    NSData *data = [noImgTagHtmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attStr.length)];
//    NSLog(@"attStr==%@",attStr);
    return attStr;
}

//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
//    NSLog(@"URL==%@",URL);
//
//    return YES;
//}

#pragma mark - 点击了链接会走这个方法 可以在这里处理操作
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    NSLog(@"URL==%@",URL);
    [Dialog simpleToast:URL.absoluteString];
    return NO;
}
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
//{
//    NSLog(@"URL==%@",URL);
//    return YES;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
