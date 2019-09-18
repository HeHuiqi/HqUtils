//
//  HqWebViewTestVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/29/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqWebViewTestVC.h"
#import <WebKit/WebKit.h>
#import "WKWebView+HqWKWebView.h"
#import "HqPreviewWebImageVC.h"
#import <SafariServices/SafariServices.h>
@interface HqWebViewTestVC ()
<
UIWebViewDelegate,
UITextViewDelegate,
WKUIDelegate,
WKNavigationDelegate
>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) WKWebView *wkWebview;
@property (nonatomic,strong) UITextView *textView;



@end

@implementation HqWebViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testUIWebView];
//    [self testWkWebView];
//    [self testTextView];
}

#pragma mark - get
- (UIWebView *)webView{
    if (!_webView) {
        CGRect rect = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight);
        _webView = [[UIWebView alloc] initWithFrame:rect];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}
- (WKWebView *)wkWebview{
    if (!_wkWebview) {
        CGRect rect = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight);
        _wkWebview = [[WKWebView alloc] initWithFrame:rect];
        _wkWebview.UIDelegate = self;
        _wkWebview.navigationDelegate = self;
    }
    return _wkWebview;
}
- (UITextView *)textView{
    if (!_textView) {
        CGRect rect = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight);

        _textView = [[UITextView alloc] initWithFrame:rect];
        _textView.delegate = self;
        _textView.editable = NO;
    }
    return _textView;
}


- (void)requsetContentComplate:(void(^)(NSString *conent))complate{
    NSString *url = @"https://api.lcyoufu.com/v1/article/profile?articleid=172522";
    [HqHttpUtil hqGet:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dataDic = [responseObject hq_objectForKey:@"data"];
        NSString *htmlContent = [dataDic hq_objectForKey:@"content"];
        complate(htmlContent);
    }];
}


#pragma mark testUIwebView
- (void)testUIWebView{
    [self.view addSubview:self.webView];
    
//    NSString *html = @"<img src='http://cdn.lcyoufu.com/assets/activity/eos/poster.png?x-oss-process=style/style'/>";
    
    NSString *template = [[NSBundle mainBundle] pathForResource:@"open.html" ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:template encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:nil];

    return;
    [self requsetContentComplate:^(NSString *conent) {
        conent = [self formatHtmlStr:conent title:@"HAHAHA"];

        [self.webView loadHTMLString:conent baseURL:nil];
    }];
}


#pragma mark - testWKWebView
- (void)testWkWebView{
    [self.view addSubview:self.wkWebview];
    [self requsetContentComplate:^(NSString *conent) {
        conent = [self formatHtmlStr:conent title:@"HAHAHA"];

        [self.wkWebview loadHTMLString:conent baseURL:nil];
    }];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView hqWebViewDidFinishNavigation:navigation];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //预览图片
   BOOL isJump =  [webView clickImgTagWithWKNavigationAction:navigationAction callback:^(NSString * _Nonnull imgurl, NSInteger index) {
//       NSLog(@"index = %@",@(index));
//       NSLog(@"imgurl = %@",imgurl);
//        NSLog(@"webView.imageUrls==%@",webView.imageUrls);


     
       if (@available(iOS 9.0, *)) {
//           #import <SafariServices/SafariServices.h>
           NSURL *url = [NSURL URLWithString:imgurl];
           SFSafariViewController *sf = [[SFSafariViewController alloc] initWithURL:url];
           Present(sf);
       } else {
           HqPreviewWebImageVC *vc = [[HqPreviewWebImageVC alloc] init];
           vc.imageUrl = imgurl;
//           Push(vc);
           [self showViewController:vc sender:nil];
       }
    
    }];
    
    if (isJump) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

#pragma mark - testTextView
- (void)testTextView{
    [self.view addSubview:self.textView];
    
    NSMutableAttributedString *matrs = [[NSMutableAttributedString alloc] initWithString:@"这可是电光火石的好看噶时光啊电话给卡上打噶客户端观看了卡和高考啦卡上打噶"];
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
    imageAttachment.image = [UIImage imageNamed:@"640.jpg"];
    imageAttachment.bounds = CGRectMake(0, 0, self.view.bounds.size.width-10, 200);
//    imageAttachment.contents = [@"image_index_1" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSAttributedString *imageAtrs = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [matrs insertAttributedString:imageAtrs atIndex:10];
    self.textView.attributedText = matrs;
    /*
    [self requsetContentComplate:^(NSString *conent) {
        conent = [self formatHtmlStr:conent title:@"HAHAHA"];
        NSAttributedString *atrs = [[NSAttributedString alloc] initWithData:[conent dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        self.textView.attributedText = atrs;
    }];
    */
}
- (NSString *)formatHtmlStr:(NSString *)html title:(NSString *)title{
    if (html.length==0) {
        return @"";
    }
    if ([html containsString:@"\n"]) {
        html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        html = [NSString stringWithFormat:@"<p style=\"font-size:large;\">%@</p>",html];
    }
    NSString *template = [[NSBundle mainBundle] pathForResource:@"article_template.html" ofType:nil];
    NSString *result = [NSString stringWithContentsOfFile:template encoding:NSUTF8StringEncoding error:nil];
    NSString *scw = [NSString stringWithFormat:@"%@",@(SCREEN_WIDTH-20)];
    result = [result stringByReplacingOccurrencesOfString:@"{title}" withString:title];
    result = [result stringByReplacingOccurrencesOfString:@"{content}" withString:html];
    result = [result stringByReplacingOccurrencesOfString:@"{screen_width}" withString:scw];
    return result;
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    NSLog(@"textAttachment==%@",textAttachment);
    return YES;
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
