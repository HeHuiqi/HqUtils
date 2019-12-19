//
//  HqPhotoPickerVC.m
//  HqUtils
//
//  Created by hehuiqi on 9/27/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPhotoPickerVC.h"
#import <TZImagePickerController/TZImagePickerController.h>
@interface HqPhotoPickerVC ()<TZImagePickerControllerDelegate>

@property(nonatomic,strong) UIButton *selectPhotoBtn;
@property(nonatomic,strong) UIImageView *showImageView;
@end

@implementation HqPhotoPickerVC

- (UIButton *)selectPhotoBtn{
    if (!_selectPhotoBtn) {
        _selectPhotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectPhotoBtn setTitle:@"选择相片" forState:UIControlStateNormal];
    }
    return _selectPhotoBtn;
}
- (UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
        _showImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _showImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.selectPhotoBtn];
    [self.selectPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.selectPhotoBtn.mas_bottom).offset(20);
        CGFloat width = self.view.bounds.size.width - 30;
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    
    [self.selectPhotoBtn addTarget:self action:@selector(bntClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)bntClick:(UIButton *)btn{
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:2 delegate:self];
    picker.allowCameraLocation = NO;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIImage *image = photos.lastObject;
    self.showImageView.image = image;
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
