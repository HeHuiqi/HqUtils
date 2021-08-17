//
//  HqNSURLSession.h
//  NetworkTest
//
//  Created by macpro on 15/11/9.
//  Copyright © 2015年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void  (^HqRequestTaskComplete)( NSHTTPURLResponse *response,id responseData);

@interface HqNSURLSession : NSObject

+ (NSURLSessionDataTask *)createSessionTasWithHeaders:(NSDictionary *)headers
                                            urlString:(NSString *)urlstring
                                        requestMethod:(NSString *)method
                                              params:(id)params
                                            withBlock:(HqRequestTaskComplete)myRequestTaskComplet;

@end
