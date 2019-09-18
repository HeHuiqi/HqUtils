//
//  HqMutilImagePickerVC.m
//  HqUtils
//
//  Created by hehuiqi on 7/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqMutilImagePickerVC.h"
#import "HqPickerImageCell.h"
#import "HqAlertView.h"
@interface HqMutilImagePickerVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *allImageModels;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *allSelectImageModels;



@end

@implementation HqMutilImagePickerVC

- (instancetype)init{
    if (self = [super init]) {
        self.maxSelectCount = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择图片";
    self.allImageModels  = [[NSMutableArray alloc] initWithCapacity:0];
    self.allSelectImageModels = [[NSMutableArray alloc] initWithCapacity:0];
    [self initView];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            HqAlertView *alert = [[HqAlertView alloc] initWithTitle:@"App需要访问您的照片" message:nil];
            alert.btnTitles = @[@"取消",@"确定"];
            [alert showVC:self callBack:^(UIAlertAction *action, int index) {
                if (index == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }else{
                    Dismiss();
                }
                
            }];
            
        }else{
            [self getImagesFromCameraRoll];
        }
    }];
}
- (void)initView{
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:HqPickerImageCell.class forCellWithReuseIdentifier:HqPickerImageCellID];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectImages)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    Back();
}
- (void)didSelectImages{
    if (self.allSelectImageModels.count>0) {
        if (self.delegate) {
//            [self.delegate hqMutilImagePickerVC:self didSelectedImageModels:self.allSelectImageModels];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        Back();
    }else{
        [Dialog simpleToast:@"请选择图片"];
    }
}
#pragma mark - get
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat space = 4*(1.0/[UIScreen mainScreen].scale);
        layout.minimumLineSpacing = space;
        layout.minimumInteritemSpacing = space;
        CGFloat width = self.view.bounds.size.width;
        CGFloat itemWidth = (width - space*3)/4.0;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allImageModels.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HqPickerImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HqPickerImageCellID forIndexPath:indexPath];
    HqMutilImagePickerModel *model = self.allImageModels[indexPath.row];
    cell.pickerModel = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HqMutilImagePickerModel *model = self.allImageModels[indexPath.row];
    model.selected = !model.selected;
    NSLog(@" model.selected==%@",@(model.selected));
    if (model.selected) {
        if (self.maxSelectCount>0 && self.allSelectImageModels.count>=self.maxSelectCount) {
            NSString *maxStr = [NSString stringWithFormat:@"最多选%@张",@(self.maxSelectCount)];
            [Dialog simpleToast:maxStr];
            model.selected = NO;
            return;
        }
        if (![self.allSelectImageModels containsObject:model]) {
            [self.allSelectImageModels addObject:model];
        }
    }else{
        if ([self.allSelectImageModels containsObject:model]) {
            [self.allSelectImageModels removeObject:model];
        }
    }
    [collectionView reloadData];
}
/**
 *  获得相机胶卷中的所有图片
 */
- (void)getImagesFromCameraRoll
{
    // 获得相机胶卷中的所有图片
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithOptions:nil];
    [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HqMutilImagePickerModel *model = [[HqMutilImagePickerModel alloc] init];
        model.phAsset = obj;
        model.selected = NO;
        [self.allImageModels addObject:model];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allImageModels.count-1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
    });
}
- (void)getAssetOrginalImageWithAssect:(PHAsset *)asset callback:(void(^)(UIImage *image))callback{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.version = PHImageRequestOptionsVersionOriginal;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    options.version = PHImageRequestOptionsVersionCurrent;
    PHImageManager *phImageM =  [PHImageManager defaultManager];
    CGFloat scaleW = SCREEN_WIDTH/(asset.pixelWidth/2.0);
    CGFloat scaleH = SCREEN_HEIGHT/(asset.pixelHeight/2.0);
    CGFloat width = asset.pixelWidth*scaleW;
    CGFloat heiht  = asset.pixelHeight*scaleH;
    [phImageM requestImageForAsset:asset targetSize:CGSizeMake(width, heiht) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callback(result);
    }];
    
}

- (void)showInVC:(UIViewController *)vc{
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self];
    [vc presentViewController:navVC animated:YES completion:nil];
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
