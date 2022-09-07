//
//  HqCodeVC.m
//  HqUtils
//
//  Created by hehuiqi on 6/21/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCodeVC.h"
#import "HqLoopScrollVIew.h"
#import "HqLoopView.h"
#import "HqRichTextView.h"
#import "HqRichTextUtil.h"
#import "HqUILable.h"
#import "HqButton.h"
#import "HqUIButton.h"
#import "HqTextFiled.h"
#import "HqLab.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import "HqCornerCell.h"
#import "UITableView+CornerCell.h"
#import "HqUITextField.h"

#import "HqLableButton.h"

@interface HqCodeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSUInteger page;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) UIImageView *imageV;

@property(nonatomic,strong) HqUILable *qLable;
@property(nonatomic,strong) HqButton *qBtn;
@property(nonatomic,strong) HqLab *lab;

@property(nonatomic,strong) HqUIButton *btn;

@end

@implementation HqCodeVC

- (HqUILable *)qLable{
    if (!_qLable) {
        _qLable = [[HqUILable alloc] init];
        _qLable.backgroundColor = [UIColor colorWithRed:196.0/255 green:58.0/255.0 blue:133.0/255 alpha:1.0];
        _qLable.font = [UIFont systemFontOfSize:16];
        _qLable.textColor = [UIColor whiteColor];
        _qLable.numberOfLines = 0;
    }
    return _qLable;
}
- (HqButton *)qBtn{
    if (!_qBtn) {
        _qBtn = [[HqButton alloc] init];
    }
    return _qBtn;
}
- (void)test_img {
    NSString *str = @"abcdefg";
    str = @"a";
    
    UIImageView *imgv = [[UIImageView alloc] init];
    imgv.backgroundColor = [UIColor redColor];
    [self.view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(self.navBarHeight + 30);
    }];
    
    CGRect rect  = {0,0,60,30};
    CGRect rect1 = CGRectOffset(rect, 3, 5);
    NSLog(@"rect1==%@",@(rect1));
    CGRect rect2 = CGRectInset(rect, 3, 5);
    NSLog(@"rect2==%@",@(rect2));
    
    UIFont *font = SetFont(20);
    NSLog(@"%@,%@,%@,%@",@(font.lineHeight),@(font.ascender),@(font.descender),@(font.pointSize));
    CGFloat originY = (30 - font.lineHeight )/2.0;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        NSDictionary *attributes = @{NSFontAttributeName:SetFont(20),
                                     NSForegroundColorAttributeName:[UIColor blueColor],
                                     NSBackgroundColorAttributeName:[UIColor grayColor]};
        [str drawAtPoint:CGPointMake(0, originY) withAttributes:attributes];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imgv.image = image;
            
        });
    });
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    [self testView];
//    [self currentVC];
//    [self testTabView];
//    [self testLoopView];

//    [self testRichtext];
//    [self testSizeFit];
//    [self testIntrinsicContentSize];
//    [self testBtn];
    

//    [self testTf];
//    [self testLab];
//    [self numLab];
    
    [self test_img];
    

}
- (UIImage *)getScreenshot:(CALayer *)layer{
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0.0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (NSAttributedString *)numberCard:(NSInteger)number font:(UIFont *)font unit:(NSString *)unit{
    NSString *numStr = [NSString stringWithFormat:@"%02ld",number];
    NSString *num1 = [numStr substringToIndex:1];
    NSString *num2 = [numStr substringFromIndex:1];
    
    UIImage *image1 = [self textToImage:num1 font:SetFont(10) size:CGSizeMake(12, 16)];
    UIImage *image2 = [self textToImage:num2 font:SetFont(10) size:CGSizeMake(12, 16)];
    
    CGFloat imgH = image1.size.height + 2;
    CGFloat offsetY  = (font.lineHeight + font.descender  - imgH)/2.0;

    NSMutableAttributedString *atrs = [[NSMutableAttributedString alloc] init];
    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@" "];

    NSTextAttachment *at1 = [[NSTextAttachment alloc] init];
    at1.image = image1;
    at1.bounds = CGRectMake(0, offsetY, image1.size.width, image1.size.height);

    NSTextAttachment *at2 = [[NSTextAttachment alloc] init];
    at2.image = image2;
    at2.bounds = CGRectMake(0, offsetY, image2.size.width, image2.size.height);
    
    NSAttributedString *atrsAt1 = [NSAttributedString attributedStringWithAttachment:at1];
    NSAttributedString *atrsAt2 = [NSAttributedString attributedStringWithAttachment:at2];
    [atrs appendAttributedString:space];
    [atrs appendAttributedString:atrsAt1];
    [atrs appendAttributedString:space];
    [atrs appendAttributedString:atrsAt2];
    [atrs appendAttributedString:space];
    NSMutableAttributedString *unitAtr = [[NSMutableAttributedString alloc] initWithString:unit];

    [atrs appendAttributedString:unitAtr];
    

    
    
    return atrs;
}
- (UIImage *)textToImage:(NSString *)text font:(UIFont *)font size:(CGSize)size{
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = text;
    lab.layer.borderWidth = 1.0;
    lab.font = font;
    lab.layer.borderColor = COLORA(204, 204, 204).CGColor;
    lab.layer.cornerRadius = 2;
    lab.clipsToBounds = YES;
    lab.frame = CGRectMake(0, 0, size.width, size.height);
    UIImage *image = [self getScreenshot:lab.layer];
    return  image;
}
- (NSAttributedString *)showTime:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second font:(UIFont *)font{
    NSMutableAttributedString *atrs = [[NSMutableAttributedString alloc] initWithString:@"投票倒计时:"];
    NSAttributedString *hourAtr = [self numberCard:9 font:font unit:@"小时"];
    NSAttributedString *minuteAtr = [self numberCard:8 font:font unit:@"分钟"];
    NSAttributedString *secondAtr = [self numberCard:7 font:font unit:@"秒"];
    [atrs appendAttributedString:hourAtr];
    [atrs appendAttributedString:minuteAtr];
    [atrs appendAttributedString:secondAtr];
    return atrs;
}
- (void)numLab{


//    UIImage *image =  [self textToImage:@"9" font:SetFont(10) size:CGSizeMake(12, 16)];

    
    UIFont *font = SetFont(12);
    NSAttributedString *atrs = [self showTime:9 minute:9 second:9 font:font];
    
    UILabel *show_lab =  [[UILabel alloc] init];
    show_lab.backgroundColor = [UIColor redColor];
    show_lab.font = font;
    show_lab.attributedText = atrs;
    [self.view addSubview:show_lab];
   
    
    [show_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(self.navBarHeight + 30);
    }];
}
- (void)testLab{
    self.lab = [[HqLab alloc] init];
    self.lab.numberOfLines = 0;
    [self.view addSubview:self.lab];
    self.lab.backgroundColor = HqRandomColor;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];



}
- (void)testView{
    HqUITextField *tf = [[HqUITextField alloc] init];
    tf.contentInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    tf.placeholder = @"请输入";
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(self.navBarHeight + 20);
        make.width.mas_equalTo(self.view.bounds.size.width - 20);
        make.height.mas_equalTo(40);
    }];
    tf.backgroundColor = HqRandomColor;
    
    HqLableButton *labBtn = [[HqLableButton alloc] init];
    labBtn.lableAlign = HqLableAlignCenter;
    labBtn.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    labBtn.labSpace = 5;
    [self.view addSubview:labBtn];
    [labBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(tf.mas_bottom).offset(20);
    }];
    
    labBtn.titleLab.text = @"今日收益";
    labBtn.contentLab.text = @"50.134\n万";
    
}
- (void)testTf{
    HqTextFiled *tf = [[HqTextFiled alloc] init];
//    tf.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(self.view).offset(self.navBarHeight + 20);
        make.size.mas_equalTo(CGSizeMake(240, 40));
    }];
    for (UIView *view in tf.subviews) {
        NSLog(@"view==%@",view);
        for (UIView *sbview in view.subviews) {
            NSLog(@"sbview==%@",sbview);
        }
    }
    
}
- (NSArray *)findDuplicateItem:(NSArray *)items{
    if (items.count <=1) {
        return nil;
    }
    NSMutableArray *duplicateItem = @[].mutableCopy;
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (NSNumber * item  in items) {
        if (![set containsObject:item]) {
            [set addObject:item];
        }else{
            [duplicateItem addObject:item];
        }
    }
    NSLog(@"duplicateItem==%@",duplicateItem);
    return duplicateItem;
}
- (void)testBtn{
    HqUIButton *btn = [HqUIButton buttonWithType:UIButtonTypeCustom];
    btn.imageLabelSpace = 10;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.imagePosition = HqUIButtonImagePositionLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    btn.normalImage = [UIImage imageNamed:@"collect_icon"];
    btn.selectedImage = [UIImage imageNamed:@"collect_selected_icon"];
    btn.normalTitle = @"收藏100";
    btn.normalTitleColor = [UIColor blueColor];
    btn.selectedTitleColor = [UIColor redColor];
    btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    btn.layer.cornerRadius = 4;
    self.btn = btn;
    

    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(self.navBarHeight+20);
//        make.width.mas_equalTo(70);
    }];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.qBtn];
    [self.qBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(btn.mas_bottom).offset(10);
//        make.top.equalTo(self.view).offset(self.navBarHeight+20);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(100);
    }];
    self.qBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    UIImage *normalBgImage = [UIImage createImageWithColor:[UIColor blueColor]];
//    UIImage *highlightedBgImage = [UIImage createImageWithColor:[UIColor redColor]];
//    self.qBtn.normalBackgroundImage = normalBgImage;
//    self.qBtn.highlightedBackgroundImage = highlightedBgImage;
    
    self.qBtn.labIconSpace = 10;
    self.qBtn.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //左右布局
    self.qBtn.style = HqButtonStyleIconLeft;
//    self.qBtn.style = HqButtonStyleIconRight;
    
    //上下布局
//    self.qBtn.style = HqButtonStyleIconTop;
//    self.qBtn.style = HqButtonStyleIconBottom;
//    self.qBtn.style = HqButtonStyleOnlyShowIcon;
//    self.qBtn.style = HqButtonStyleOnlyShowLab;



    self.qBtn.normalImage = [UIImage imageNamed:@"collect_icon"];
    self.qBtn.selectedImage = [UIImage imageNamed:@"collect_selected_icon"];
    self.qBtn.lable.text = @"收藏900000";
//    self.qBtn.lable.text = @"2000点赞";

    self.qBtn.normalTextColor = [UIColor colorWithRed:161.0/255 green:161.0/255 blue:161.0/255 alpha:1.0];
    self.qBtn.selectedTextColor = [UIColor colorWithRed:255.0/255 green:198.0/255 blue:23.0/255 alpha:1.0];
    
//    self.qBtn.tintColor = [UIColor blueColor];
    
    self.qBtn.layer.cornerRadius = 4;
    self.qBtn.clipsToBounds = YES;
    
    [self.qBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.qBtn.disEanbleTextColor = [UIColor purpleColor];


}

- (void)testIntrinsicContentSize{

    
    [self.view addSubview:self.qLable];
//    self.qLable.frame = CGRectMake(10, self.navBarHeight + 20, 100, 50);

    self.qLable.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.qLable.text = @"Lable可以设置边距了";
    [self.qLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(self.navBarHeight+20);
//        make.width.mas_equalTo(100);
    }];
    
    [self.view addSubview:self.qBtn];
    [self.qBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.qLable.mas_bottom).offset(10);
//        make.top.equalTo(self.view).offset(self.navBarHeight+20);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(40);
    }];
    self.qBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    UIImage *normalBgImage = [UIImage createImageWithColor:[UIColor blueColor]];
//    UIImage *highlightedBgImage = [UIImage createImageWithColor:[UIColor redColor]];
//    self.qBtn.normalBackgroundImage = normalBgImage;
//    self.qBtn.highlightedBackgroundImage = highlightedBgImage;
    
    self.qBtn.labIconSpace = 10;
    
    //左右布局
//    self.qBtn.style = HqButtonStyleIconLeft;
//    self.qBtn.contentInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //上下布局
    self.qBtn.style = HqButtonStyleIconTop;
    self.qBtn.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    

    self.qBtn.normalImage = [UIImage imageNamed:@"collect_icon"];
    self.qBtn.selectedImage = [UIImage imageNamed:@"collect_selected_icon"];
    self.qBtn.lable.text = @"收藏100";
    self.qBtn.normalTextColor = [UIColor colorWithRed:161.0/255 green:161.0/255 blue:161.0/255 alpha:1.0];
    self.qBtn.selectedTextColor = [UIColor colorWithRed:247.0/255 green:200.0/255 blue:71.0/255 alpha:1.0];
    
    self.qBtn.layer.cornerRadius = 4;
    self.qBtn.clipsToBounds = YES;
    
    [self.qBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnClick:(UIControl *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [Dialog simpleToast:@"收藏成功"];

    }else{
        [Dialog simpleToast:@"取消收藏成功"];
    }
}
- (void)testRichtext{
    NSString *html = @"<p>征文测试征文测试征文测试</p><p>征文测试征文测试征文测试</p><p><br/></p><p><img src=\"https://lichang-dev.oss-cn-shanghai.aliyuncs.com/user/43/postArt/98932ba5afe8d65e6e393a75449b1c7e.jpg?x-oss-process=style/style\"/>征文测试</p><p><br/></p><p><br/></p><p><br/></p><p>征文测试征文测试征文测试征文测试征文测试征文测试</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>征文测试征文测试征文测试征文测试征文测试征文测试</p><p>征文测试征文测试<br/></p><p>征文测试征文测试<br/></p>";
    
    HqRichTextView *tv = [[HqRichTextView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    tv.backgroundColor = HqRandomColor;
    [self.view addSubview:tv];
    [tv loadHtml:html];

    
    /*
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    tv.backgroundColor = HqRandomColor;
    [self.view addSubview:tv];

    [self.view addSubview:self.imageV];
    CGFloat maxWidth = tv.bounds.size.width-tv.textContainer.lineFragmentPadding*2;
    [HqRichTextUtil createAttributedStringWithHtml:html contentWidth:maxWidth complete:^(NSMutableAttributedString * _Nonnull result) {
        tv.attributedText = result;
    }];
    */
}

- (NSAttributedString *)htmlToAttributedString{

    NSString *html = @"<p>征文测试征文测试征文测试</p><p>征文测试征文测试征文测试</p><p><br/></p><p><img src=\"https://lichang-dev.oss-cn-shanghai.aliyuncs.com/user/43/postArt/98932ba5afe8d65e6e393a75449b1c7e.jpg?x-oss-process=style/style\"/>征文测试</p><p><br/></p><p><br/></p><p><br/></p><p>征文测试征文测试征文测试征文测试征文测试征文测试</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>征文测试征文测试征文测试征文测试征文测试征文测试</p><p>征文测试征文测试<br/></p><p>征文测试征文测试<br/></p>";
    
    NSArray *allSrc = [self htmlAllImgSrc:html];
    NSLog(@"allSrc=%@",allSrc);
    
    NSMutableArray *replaceAttachments = @[].mutableCopy;
    
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
    options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
    NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                  documentAttributes:nil error:nil];
    

    [attributeString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributeString.length) options:(NSAttributedStringEnumerationReverse) usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        NSTextAttachment *attachment = value;
        if (attachment) {
            NSFileWrapper *fileWrapper = attachment.fileWrapper;
            //NSLog(@"attachment==%@",attachment);
            NSLog(@"range==%@",NSStringFromRange(range));

            NSLog(@"attachment.fileType==%@",attachment.fileType);
            NSLog(@"attachment.fileWrapper==%@",fileWrapper);
            NSLog(@"fileWrapper.filename==%@",fileWrapper.filename);
            NSLog(@"fileWrapper.preferredFilename==%@",fileWrapper.preferredFilename);
            NSLog(@"fileWrapper.fileAttributes==%@",fileWrapper.fileAttributes);
            UIImage *image = [UIImage imageWithData:fileWrapper.regularFileContents];
            if (fileWrapper.isSymbolicLink) {
                NSLog(@"fileWrapper.symbolicLinkDestinationURL==%@",fileWrapper.symbolicLinkDestinationURL);
            }else{
                NSLog(@"no symbolicLink");
            }
            NSLog(@"fileWrapper.serializedRepresentation==%@",image);
            NSLog(@"self.imageV==%@",self.imageV);
            HqTextAttachment *attachment = [[HqTextAttachment alloc] init];
            attachment.image = image;
            attachment.range = range;
            
            CGFloat width = self.view.bounds.size.width-10;
            CGFloat height = image.size.height;
            CGFloat imageScale = height/image.size.width;
            if (image.size.width>width) {
                height = width *imageScale;
            }else{
                width = image.size.width;
            }
            attachment.bounds = CGRectMake(0, 0, width, height);
            [allSrc enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj containsString:fileWrapper.preferredFilename]) {
                    attachment.urlString = obj;
                    [replaceAttachments addObject:attachment];
                    return;
                }
            }];

//            NSLog(@"attachment.contents==%@",attachment.contents);
//            NSLog(@"attachment.image==%@",attachment.image);
        }
        
    }];
    
    for (HqTextAttachment *attachment in replaceAttachments) {
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [attributeString replaceCharactersInRange:attachment.range withAttributedString:attrStr];
    }
    
    return attributeString;
}
- (NSArray *)htmlAllImgSrc:(NSString *)html{
    NSMutableArray *allSrc = @[].mutableCopy;
    NSString *content = html;
    NSString  *pattern = @"<img [^>]*src=['\"]([^'\"]+)[^>]*>";
    NSArray *imgTags = [self findString:content regexString:pattern];
    for (NSDictionary *imgeTagDic in imgTags) {
        NSString *imgeTag = [imgeTagDic objectForKey:@"match"];
        pattern = @"src=['\"]([^'\"]+)['\"]";
        NSDictionary *imageSrcDic = [self findString:imgeTag regexString:pattern].firstObject;
        NSString *matchSrc = [imageSrcDic objectForKey:@"match"];
        NSString *src = [matchSrc substringFromIndex:4];
        [allSrc addObject:src];
    }
    return allSrc;
}
- (NSArray *)findString:(NSString *)string regexString:(NSString *)regexString
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    NSMutableArray *results = @[].mutableCopy;
    
    for (NSTextCheckingResult *result in matches) {
        NSString *rangeStr = NSStringFromRange(result.range);
        NSString *matchStr = [string substringWithRange:result.range];
        NSDictionary *dic = @{@"range":rangeStr,@"match":matchStr};
        [results addObject:dic];
    }
    NSLog(@"results==%@",results);
    return results;
//    return matches;
}
- (void)testBlock{
    int (^Multipy)(int,int) = ^(int a, int b){
        return a*b;
    };
    int result = Multipy(2,3);
    NSLog(@"result==%@",@(result));
}
- (void)testHook{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    [btn setTitle:@"去登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn  addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)goLogin:(UIButton *)btn{
}
- (id)currentVC{
    UIWindow *currentWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootVC = currentWindow.rootViewController;
    
    UIViewController * _Nullable (^HqNavTopVC)(UIViewController *) = ^(UIViewController *vc) {
        UIViewController *topVC = nil;
        if ([vc isKindOfClass:UINavigationController.class]) {
            NSArray *vcs = vc.childViewControllers;
            if (vcs.count>0) {
                NSInteger preIndex = (vcs.count-2);
                preIndex = preIndex<=0 ? 0:preIndex;
               UIViewController *topVC  = vcs[preIndex];
                NSLog(@"vc==%@,title=%@",topVC.class,topVC.title);
            }
        }
        return topVC;
    };
    
    if (rootVC) {
        if ([rootVC isKindOfClass:UITabBarController.class]) {
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            UIViewController *selectedVC = tabVC.selectedViewController;
            return HqNavTopVC(selectedVC);
        }
        if ([rootVC isKindOfClass:UINavigationController.class]) {
            return HqNavTopVC(rootVC);
        }
    }
    return nil;

}
- (void)testHqLoop{
    HqLoopView *hqLoopView = [[HqLoopView alloc] initWithFrame:CGRectMake(20, 100, 300, 200)];
    hqLoopView.loopViewType = HqLoopViewTypePlain;
    [self.view addSubview:hqLoopView];
    hqLoopView.backgroundColor = [UIColor blackColor];
    [hqLoopView testData];
}
- (void)testLoopView{
    HqLoopScrollVIew *hqLoopView = [[HqLoopScrollVIew alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 200)];
    hqLoopView.loop = YES;
    [self.view addSubview:hqLoopView];
    hqLoopView.backgroundColor = [UIColor blackColor];
    [hqLoopView testData];
}
- (void)dealloc{
    NSLog(@"dealloc");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.qBtn.lable.text = @"100000000点赞";
    self.btn.normalTitle = @"abc";
    
}
- (void)initView{
    
}
- (void)testTabView{
    self.datas = @[].mutableCopy;
    for (int i = 0; i<10; i++) {
        [self.datas addObject:@""];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
    UILabel *tableHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    tableHeader.text = @"Header";
    tableHeader.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = tableHeader;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.cellShowShadow = YES;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"HqCornerCell";
    HqCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[HqCornerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    NSInteger rows = [tableView numberOfRowsInSection:indexPath.section];
    HqCornetPosition  cornetPosition = HqCornetPositionCenter;
    if (rows == 1) {
        cornetPosition = HqCornetPositionAll;
    }else if (indexPath.row == 0) {
        cornetPosition = HqCornetPositionTop;
    }else if (indexPath.row == rows - 1) {
        cornetPosition = HqCornetPositionBottom;
    }
    cell.cornetPosition = cornetPosition;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView tableViewCell:cell corneRadius:10 marginSpace:15 forRowAtIndexPath:indexPath];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{


}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        NSLog(@"---");
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
}
#pragma mark - 请求
- (void)refreshData{
    self.page = 1;
}
- (void)loadData{
    self.page++;
}
#pragma mark 关注的
- (void)requsetFollowData{
 
}
- (void)refreshTableView:(UITableView *)tablview isNomore:(BOOL)isNomore{
    [tablview.mj_header endRefreshing];
    
    if (isNomore) {
        [tablview.mj_footer endRefreshingWithNoMoreData];
        tablview.mj_footer.alpha = 1.0;
    }else{
        [tablview.mj_footer endRefreshing];
        tablview.mj_footer.alpha = 1.0;
    }
    [tablview reloadData];
}
@end


