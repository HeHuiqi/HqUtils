//
//  HqDownLoader.m
//  NetworkTest
//
//  Created by macpro on 16/6/23.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqDownLoader.h"
@interface HqDownLoader ()<NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation HqDownLoader

//懒加载
- (NSURLSession *)session
{
    if (!_session) {
        // 获得session
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}


- (void)downloadWithURLString:(NSString *)urlString{
    
    if (self.task == nil) { // 开始（继续）下载
        if (self.resumeData) { // 恢复
            [self resume];
        } else { // 开始
            [self startWithURLString:urlString];
        }
    } else { // 暂停
        [self pause];
    }
}
/**
 *  从零开始
 */
- (void)startWithURLString:(NSString *)urlString
{
// http://file27.mafengwo.net/M00/4F/8C/wKgB6lR04MmAC5VSAAObsMrWhAE74.rbook_comment.w1024.jpeg
    // 1.创建一个下载任务
    NSURL *url = [NSURL URLWithString:urlString];
//    self.task = [self.session downloadTaskWithURL:url];
    self.task = (NSURLSessionDownloadTask *)[self.session dataTaskWithURL:url];
    // 2.开始任务
    [self.task resume];
}

/**
 *  恢复（继续）
 */
- (void)resume
{
    // 传入上次暂停下载返回的数据，就可以恢复下载
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    
    // 开始任务
    [self.task resume];
    
    // 清空
    self.resumeData = nil;
}

/**
 *  暂停
 */
- (void)pause
{
    __weak typeof(self) weakSelf = self;
    [self.task cancelByProducingResumeData:^(NSData *resumeData) {
        //  resumeData : 包含了继续下载的开始位置\下载的url
        weakSelf.resumeData = resumeData;
        weakSelf.task = nil;
    }];
}

#pragma mark -  NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandle{
    
    NSLog(@"alllength ＝%lld",response.expectedContentLength);

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSLog(@"alllength1 ＝%lld",dataTask.response.expectedContentLength);

    NSLog(@"didReceiveData = %ld",data.length);
}
#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"file = %@",file);
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 获得下载进度
    
    double pro = (double)totalBytesWritten / totalBytesExpectedToWrite;
//    NSLog(@"bytesWritten--%lld", bytesWritten);
//    NSLog(@"totalBytesExpectedToWrite--%lld", totalBytesExpectedToWrite);
    NSLog(@"获得下载进度--%f", pro);
//    NSLog(@"thread = %@",[NSThread currentThread]);

}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"bytes = %lld",expectedTotalBytes);
}
@end
