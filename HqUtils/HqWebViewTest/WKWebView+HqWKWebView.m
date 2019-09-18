//
//  WKWebView+HqWKWebView.m
//  HqUtils
//
//  Created by hehuiqi on 5/29/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "WKWebView+HqWKWebView.h"

#import <objc/message.h>
const char *ImageUrlsKey = "imageUrls";

@implementation WKWebView (HqWKWebView)

- (void)setImageUrls:(NSArray *)imageUrls{
    objc_setAssociatedObject(self, ImageUrlsKey, imageUrls, OBJC_ASSOCIATION_RETAIN);
}
- (NSArray *)imageUrls{
    return objc_getAssociatedObject(self, ImageUrlsKey);
}
- (NSString *)imageScheme{
    return @"image-preview-index";
}
- (void)hqWebViewDidFinishNavigation:(WKNavigation *)navigation{
    [self hqAddImgClickJS];
}
- (BOOL)clickImgTagWithWKNavigationAction:(WKNavigationAction *)navigationAction callback:(void(^)(NSString *imgurl, NSInteger index))callback{
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSURL * url = navigationAction.request.URL;
    if ([url.scheme isEqualToString:self.imageScheme]) {
        //图片点击回调
        NSString *absoluteString =url.absoluteString;
        NSInteger index = [[absoluteString substringFromIndex:absoluteString.length-1] integerValue];
        NSString * imgPath = self.imageUrls.count > index?self.imageUrls[index]:nil;
        callback(imgPath,index);
        return NO;
    }
    return YES;
}
- (void)hqAddImgClickJS{
    
    //    添加图片点击的回调 //imgs[i].imageIndex = i 给img标签添加一个imageIndex属性
    NSString *getImgjs = [NSString stringWithFormat:@"function hqGetImgesAddClick() {\
                          var imgs = document.getElementsByTagName('img');\
                          var imgSrcs = [];\
                          for (var i = 0; i < imgs.length; i++) {\
                                var imgTag = imgs[i];\
                                imgSrcs[i] = imgTag.src;\
                                imgTag.imageIndex = i;\
                                imgTag.onclick = function () {\
                                    window.location.href = '%@:' + this.imageIndex;\
                                }\
                            };\
                          return imgSrcs;\
                          };",self.imageScheme];
    //注入js
    [self evaluateJavaScript:getImgjs completionHandler:nil];//注入js方法
    
    //执行js方法
    __weak typeof(self)weakSelf = self;
    [self evaluateJavaScript:@"hqGetImgesAddClick()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"error == %@",error);
//        NSLog(@"urlArray = %@",result);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!error) {
            strongSelf.imageUrls = result;
        } else {
            strongSelf.imageUrls = @[];
        }
    }];
}
@end

