//
//  HqZLPhotoBrowserVC.m
//  HqUtils
//
//  Created by hehuiqi on 8/16/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqZLPhotoBrowserVC.h"
#import <Photos/Photos.h>
#import <ZLPhotoBrowser/ZLAlbumListController.h>
#import <ZLPhotoBrowser/ZLThumbnailViewController.h>
@interface HqZLPhotoBrowserVC ()
@property (nonatomic,strong) ZLPhotoActionSheet *photoActionSheet;

@end

@implementation HqZLPhotoBrowserVC

- (ZLPhotoActionSheet *)photoActionSheet
{
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
    //以下参数为自定义参数，均可不设置，有默认值
    //    actionSheet.configuration.sortAscending = self.sortSegment.selectedSegmentIndex==0;
    //    actionSheet.configuration.allowSelectImage = self.selImageSwitch.isOn;
    //    actionSheet.configuration.allowSelectGif = self.selGifSwitch.isOn;
    //    actionSheet.configuration.allowSelectVideo = self.selVideoSwitch.isOn;
    //    actionSheet.configuration.allowSelectLivePhoto = self.selLivePhotoSwitch.isOn;
    //    actionSheet.configuration.allowForceTouch = self.allowForceTouchSwitch.isOn;
    //    actionSheet.configuration.allowEditImage = self.allowEditSwitch.isOn;
    //    actionSheet.configuration.allowEditVideo = self.allowEditVideoSwitch.isOn;
    //    actionSheet.configuration.allowSlideSelect = self.allowSlideSelectSwitch.isOn;
    //    actionSheet.configuration.allowMixSelect = self.mixSelectSwitch.isOn;
    //    actionSheet.configuration.allowDragSelect = self.allowDragSelectSwitch.isOn;
    //设置相册内部显示拍照按钮
    //    actionSheet.configuration.allowTakePhotoInLibrary = self.takePhotoInLibrarySwitch.isOn;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = NO;
    //设置照片最大预览数
    //    actionSheet.configuration.maxPreviewCount = self.previewTextField.text.integerValue;
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = 3;
    //    actionSheet.configuration.maxVideoSelectCountInMix = 3;
    //    actionSheet.configuration.minVideoSelectCountInMix = 1;
    //设置允许选择的视频最大时长
    //    actionSheet.configuration.maxVideoDuration = self.maxVideoDurationTextField.text.integerValue;
    //设置照片cell弧度
    //    actionSheet.configuration.cellCornerRadio = self.cornerRadioTextField.text.floatValue;
    //单选模式是否显示选择按钮
    //    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    //    actionSheet.configuration.editAfterSelectThumbnailImage = self.editAfterSelectImageSwitch.isOn;
    //是否保存编辑后的图片
    //    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
    //是否在已选择照片上显示遮罩层
    //    actionSheet.configuration.showSelectedMask = self.maskSwitch.isOn;
    //颜色，状态栏样式
    //    actionSheet.configuration.previewTextColor = [UIColor brownColor];
    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    //    actionSheet.configuration.shouldAnialysisAsset = self.allowAnialysisAssetSwitch.isOn;
    //框架语言
    //    actionSheet.configuration.languageType = self.languageSegment.selectedSegmentIndex;
    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //    actionSheet.configuration.maxVideoDuration = 5;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;
    //记录上次选择的图片
    //    actionSheet.arrSelectedAssets = self.rememberLastSelSwitch.isOn&&self.maxSelCountTextField.text.integerValue>1 ? self.lastSelectAssets : nil;
    
    weakly(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        weakly(self);
        //        self.arrDataSources = images;
        //        self.isOriginal = isOriginal;
        //        self.lastSelectAssets = assets.mutableCopy;
        //        self.lastSelectPhotos = images.mutableCopy;
        //        [self.collectionView reloadData];
        NSLog(@"image:%@", images);
        //解析图片
        //        if (!self.allowAnialysisAssetSwitch.isOn) {
        //            [self anialysisAssets:assets original:isOriginal];
        //        }
    }];
    
    actionSheet.selectImageRequestErrorBlock = ^(NSArray<PHAsset *> * _Nonnull errorAssets, NSArray<NSNumber *> * _Nonnull errorIndex) {
        NSLog(@"图片解析出错的索引为: %@, 对应assets为: %@", errorIndex, errorAssets);
    };
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    _photoActionSheet = actionSheet;
    return _photoActionSheet;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches
              withEvent:event];
    
    [self.photoActionSheet showPreviewAnimated:YES];
    
    //    ZLAlbumListController *albumListVC = [[ZLAlbumListController alloc] initWithStyle:UITableViewStylePlain];
    //     ZLImageNavigationController *nav = [[ZLImageNavigationController alloc] initWithRootViewController:albumListVC];
    //    ZLThumbnailViewController *tvc = [[ZLThumbnailViewController alloc] init];
    //    [nav pushViewController:tvc animated:YES];
    //    [self showDetailViewController:nav sender:nil];
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
