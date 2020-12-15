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
//指定子数组大小分割数组，最后不足指定大小将剩余追加在最后
- (NSArray *)splitArray:(NSArray *)array subArrayLength:(NSInteger)length{
    NSMutableArray *splitResult = [[NSMutableArray alloc] init];

    if (array.count>0) {
//        CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();

        NSInteger itemCount = array.count;
        NSInteger index = 0;
        while (itemCount) {
            NSInteger minLen = MIN(length, itemCount);
            NSRange subRange = NSMakeRange(index, minLen);
            NSArray *subItems = [array subarrayWithRange:subRange];
            [splitResult addObject:subItems];
            itemCount -= minLen;
            index += minLen;
        }
        NSLog(@"splitResult==%@",splitResult);
//        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
//        NSLog(@"A---Linked in %@ ms", @(linkTime *1000.0));
        //Linked in 0.1560449600219727 ms
    }

    return splitResult;
}

- (void)testArraySplit{
    NSArray *testArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    [self splitArray:testArray subArrayLength:2];
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
