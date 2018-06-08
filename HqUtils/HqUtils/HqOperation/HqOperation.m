//
//  HqOperation.m
//  NSOperationUse
//
//  Created by macpro on 2018/3/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqOperation.h"
#import "DownloadOperation.h"
@interface HqOperation()

@property (nonatomic,strong) DownloadOperation *downloadOp;
@property (nonatomic,strong) NSOperationQueue *currentOperationQueue;

@end

@implementation HqOperation

- (void)setup  {
    
    _currentOperationQueue = [[NSOperationQueue alloc]init];
    
    _downloadOp = [[DownloadOperation alloc]init];
    
    [self invocationOperationWithData:@"我就是这样的人"];
    [self blockOperationWithData:@"这是一个冷漠的世界"];
    
    //    [self startOperation];
    
    //    [self addOperationQueue];
    
}
- (void)startOperation
{
    [_downloadOp start];
}
- (void)addOperationQueue
{
    [_currentOperationQueue addOperation:_downloadOp];
    _downloadOp.completionBlock = ^{
        NSLog(@"addOperationQueue ==完成");
    };
}
- (void)invocationOperationWithData:(id)data
{
    NSInvocationOperation *invacationOp = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOpComplete:) object:data];
    [invacationOp start];
}
- (void)invocationOpComplete:(id)data
{
    NSLog(@"invocationOperationWithData = %@",data);
}
- (void)blockOperationWithData:(id)data
{
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation == %@",data);
    }];
    [blockOp start];
}

@end
