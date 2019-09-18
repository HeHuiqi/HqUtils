//
//  HqUtilsTests.m
//  HqUtilsTests
//
//  Created by hehuiqi on 6/14/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HqUtilsTests : XCTestCase

@end

@implementation HqUtilsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
- (NSString *)formatUrl:(NSString *)url{
    if ([url hasPrefix:@"http"]) {
        return url;
    }
    return nil;
}
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"开始测试");
//    XCTAssertNil([self formatUrl:@"http://ww"],@"必须返回nil");
//    XCTAssertNotNil([self formatUrl:@"123"],@"不能返回nil");
    
    XCTAssertNil([self formatUrl:@"123"],@"必须返回nil");
    XCTAssertNotNil([self formatUrl:@"http://hq.com"],@"不能返回nil");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self formatUrl:@"abc"];
    }];
}

@end
