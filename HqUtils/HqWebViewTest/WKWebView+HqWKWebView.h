//
//  WKWebView+HqWKWebView.h
//  HqUtils
//
//  Created by hehuiqi on 5/29/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (HqWKWebView)

@property (nonatomic,copy,readonly) NSString *imageScheme;

@property (nonatomic,strong) NSArray *imageUrls;

- (void)hqWebViewDidFinishNavigation:(WKNavigation *)navigation;
- (BOOL)clickImgTagWithWKNavigationAction:(WKNavigationAction *)navigationAction callback:(void(^)(NSString *imgurl, NSInteger index))callback;

@end

/*
 使用方式：在WKNavigationDelegate代理中调用如下
 #pragma mark - WKNavigationDelegate
 - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView hqWebViewDidFinishNavigation:navigation];
 }
 - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //预览图片
     BOOL isJump =  [webView clickImgTagWithWKNavigationAction:navigationAction callback:^(NSString * _Nonnull imgurl, NSInteger index) {
     NSLog(@"imgPath = %@",imgurl);
     NSLog(@"index = %@",@(index));
     }];
     if (isJump) {
     decisionHandler(WKNavigationActionPolicyAllow);
     }else{
     decisionHandler(WKNavigationActionPolicyCancel);
     }
 }
 */

NS_ASSUME_NONNULL_END
