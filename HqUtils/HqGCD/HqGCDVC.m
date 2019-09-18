//
//  HqGCDVC.m
//  HqUtils
//
//  Created by hehuiqi on 7/29/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqGCDVC.h"

@interface HqGCDVC ()
@property (nonatomic,strong)NSMutableArray *resultImage;

@end

@implementation HqGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self semaphoreTest];
    [self testsyncDownload];
}

- (void)semaphoreTest{
    /*
     这里的数字表示同时可以有几个线程访问资源
     1表示一个一个按顺序范围资源，用于线程同步
     */
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(1);
    //全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //并发队列
//    queue = dispatch_queue_create("myque", DISPATCH_QUEUE_CONCURRENT);
    //串行队列
//    queue = dispatch_queue_create("myque", NULL);
    
    __block NSInteger source = 4;
    for (int i = 0; i<4; i++) {
        int j = i+1;
        dispatch_async(queue, ^{
            NSLog(@"task%@-start",@(j));
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            source--;
            sleep(1);
            dispatch_semaphore_signal(semaphore);
            NSLog(@"task%@-end--source==%@",@(j),@(source));
        });
     
    }
    //ARC 下不用release
    //dispatch_release(semaphore);
}
- (void)testsyncDownload{
    NSArray *urls = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564390062284&di=fcd6888697ef4d049c5d3d53ed51152c&imgtype=0&src=http%3A%2F%2Fimg.aiimg.com%2Fuploads%2Fallimg%2F140406%2F280082-1404061S521.jpg",
                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2440560882,3470831271&fm=26&gp=0.jpg",                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565865920550&di=1e8ece2519197a8fe9891d17ff6d6b25&imgtype=0&src=http%3A%2F%2Fi2.hexunimg.cn%2F2015-06-17%2F176804897.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564984780&di=b2ced576c50382be434cfe29fb53c7af&imgtype=jpg&er=1&src=http%3A%2F%2Fwpuploads.appadvice.com%2Fwp-content%2Fuploads%2F2013%2F06%2Fspotlight.png",
                      ];
//    [self syncDownLoadImageWithUrls:urls lastImageInfos:nil callBack:^(NSArray *imageInfos) {
//        NSLog(@"imageInfos==%@",imageInfos);
//    }];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
        dispatch_semaphore_t  semaphore = dispatch_semaphore_create(1);
        for (int i = 0; i<urls.count; i++) {
            NSLog(@"download_start");
            NSURL *url = [NSURL URLWithString:urls[i]];
            [self myDownloadImageWithUrl:url semaphore:semaphore callBack:^{
//                NSLog(@"url == %@",url);

            }];
            
        }
    }];
   
    
}
- (void)myDownloadImageWithUrl:(NSURL *)url semaphore:(dispatch_semaphore_t)semaphore callBack:(void(^)(void))callback{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            callback();
        }
        dispatch_semaphore_signal(semaphore);
    });
    
}
- (void)downloadImageWithUrl:(NSURL *)url callBack:(void(^)(void))callback{
    [ [SDWebImageManager sharedManager] loadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image) {
            NSLog(@"url==%@",url);
        }
        callback();
    }];
}
- (void)syncDownLoadImageWithUrls:(NSArray<NSURL *> *)urls lastImageInfos:(NSArray *)lastImageInfos callBack:(void(^)(NSArray *imageInfos))callback{
    NSMutableArray *copyUrls = urls.mutableCopy;
    NSURL *url = copyUrls.firstObject;
    NSMutableArray *resultImageInfos = [[NSMutableArray alloc] initWithCapacity:0];
    if (lastImageInfos.count>0) {
        [resultImageInfos addObjectsFromArray:lastImageInfos];
    }
    [ [SDWebImageManager sharedManager] loadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        //NSLog(@"url==%@",url);
        if (image) {
            NSDictionary *imageInfo = @{@"url":url,
                                        @"image":image,
                                        };
            [resultImageInfos addObject:imageInfo];
        }
        [copyUrls removeObject:url];
        if (copyUrls.count == 0) {
            callback(resultImageInfos);
        }else{
            [self syncDownLoadImageWithUrls:copyUrls lastImageInfos:resultImageInfos callBack:callback];
        }
        
    }];
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
