//
//  HqPreviewWebImageVC.m
//  HqUtils
//
//  Created by hehuiqi on 6/1/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPreviewWebImageVC.h"

@interface HqPreviewWebImageVC ()

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic,strong) UIImageView *previewImageView;


@end

@implementation HqPreviewWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片预览";
    [self.view addSubview:self.previewImageView];
    [self.previewImageView addSubview:self.activityIndicatorView];
    if ([self.imageUrl hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        [self.activityIndicatorView startAnimating];
        //模拟请求延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.previewImageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [self.activityIndicatorView stopAnimating];
            }];
        });
    }
}
- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.center = self.previewImageView.center;
    }
    return _activityIndicatorView;
}
- (UIImageView *)previewImageView{
    if (!_previewImageView) {
        _previewImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _previewImageView.contentMode = UIViewContentModeScaleAspectFit;
        _previewImageView.backgroundColor = [UIColor blackColor];
    }
    return _previewImageView;
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
