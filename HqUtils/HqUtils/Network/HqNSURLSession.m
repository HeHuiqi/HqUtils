//
//  HqNSURLSession.m
//  NetworkTest
//
//  Created by macpro on 15/11/9.
//  Copyright © 2015年 macpro. All rights reserved.
//

#import "HqNSURLSession.h"

@interface HqNSURLSession ()<NSURLSessionDataDelegate,NSURLSessionTaskDelegate>

@end

@implementation HqNSURLSession

+ (instancetype)shareInstance
{
    static HqNSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[self alloc]init];
    });
    return session;
}
+ (NSURLSession *)createMyURLSession{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:[self shareInstance] delegateQueue:[NSOperationQueue mainQueue]];
    return urlSession;
}
#pragma mark - 创建请求
+ (NSMutableURLRequest *)createRequestWithHeaders:(NSDictionary *)headers urlString:(NSString *)urlstring requestMethod:(NSString *)method params:(id)params{
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    if (params)
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        if ([method isEqualToString:@"GET"])
        {
            urlstring = [urlstring stringByAppendingString:jsonStr];
            url = [NSURL URLWithString:urlstring];
            request = [NSMutableURLRequest requestWithURL:url];
        }
        else
        {
            url = [NSURL URLWithString:urlstring];
            request = [NSMutableURLRequest requestWithURL:url];
            
            request.HTTPBody = data;
        }
        
    }
    else
    {
        url = [NSURL URLWithString:urlstring];
        request = [NSMutableURLRequest requestWithURL:url];
    }
    
    request.HTTPMethod = method;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (headers)
    {
        [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request addValue:obj forHTTPHeaderField:key];
        }];
    }
    NSLog(@"url = %@",urlstring);
    return request;
}
#pragma mark - 发起任务
+ (NSURLSessionDataTask *)createSessionTasWithHeaders:(NSDictionary *)headers
                                            urlString:(NSString *)urlstring
                                        requestMethod:(NSString *)method
                                              params:(id)params
                                            withBlock:(HqRequestTaskComplete)myRequestTaskComplet
{
    NSURLSession *session = [self createMyURLSession];

    NSMutableURLRequest *request  =[self createRequestWithHeaders:headers urlString:urlstring requestMethod:method params:params];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
        myRequestTaskComplet(httpURLResponse,dataString);
    }];
    [task resume];
    return task;
}

@end
