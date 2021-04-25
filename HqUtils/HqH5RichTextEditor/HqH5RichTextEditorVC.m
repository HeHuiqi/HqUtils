//
//  HqH5RichTextEditorVC.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/3.
//  Copyright © 2021 hhq. All rights reserved.
//
// https://github.com/capricorncd/zx-editor
#import "HqH5RichTextEditorVC.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>

@interface HqH5RichTextEditorVC ()
<
UITextViewDelegate,
WKUIDelegate,
WKNavigationDelegate
>

@property (nonatomic,strong) WKWebView *wkWebview;
@property (nonatomic,strong) UITextView *textView;


@end

@implementation HqH5RichTextEditorVC
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addObserverKeyboardChange{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideNotify:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)keyboardShowHideNotify:(NSNotification *)notify{
    CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardFrame);
    NSLog(@"keyboardHeight==%@",@(keyboardHeight));

    /*
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect rect = self.wkWebview.frame;
        rect.size.height = rect.size.height - keyboardHeight;
        self.wkWebview.frame = rect;
    
    }else{
        CGRect rect = self.wkWebview.frame;
        rect.size.height = SCREEN_HEIGHT - self.navBarHeight;
        self.wkWebview.frame = rect;
    }
    */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布文章";
    [self testWkWebView];
    NSString *editor_path = [[NSBundle mainBundle] pathForResource:@"hq_editor/hq_editor_index.html" ofType:nil];
    NSURL *editor_url = [NSURL fileURLWithPath:editor_path];
    NSURLRequest *req = [NSURLRequest requestWithURL:editor_url];
    [self.wkWebview loadRequest:req];
    [self addObserverKeyboardChange];
}

#pragma mark - get

- (WKWebView *)wkWebview{
    if (!_wkWebview) {
        CGRect rect = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight);
        _wkWebview = [[WKWebView alloc] initWithFrame:rect];
        _wkWebview.UIDelegate = self;
        _wkWebview.navigationDelegate = self;
    }
    return _wkWebview;
}

#pragma mark - testWKWebView
- (void)testWkWebView{
    [self.view addSubview:self.wkWebview];
    
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}



@end
