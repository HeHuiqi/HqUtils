//
//  HqUtilsUITests.m
//  HqUtilsUITests
//
//  Created by hehuiqi on 6/14/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HqUtilsUITests : XCTestCase

@end

@implementation HqUtilsUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];

    //测试Alert
    [app.navigationBars[@"HqUtils"].buttons[@"Alert"] tap];
    XCUIElement *mainWindow = [[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0];
    XCUIElement *alertVC = [[mainWindow childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1];
    XCUIElement *itemView = [alertVC childrenMatchingType:XCUIElementTypeOther].element;
    [itemView tap];
    
//    [[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element tap];
    
    //测试table跳转
    [app.tables.staticTexts[@"HqInvokeManagerVC"] tap];
    //测试点击button
    [app.buttons[@"开始调用"] tap];
    
    XCUIElementQuery *quey =  [app childrenMatchingType:XCUIElementTypeWindow];
    //获取window
    XCUIElement *window = [quey elementBoundByIndex:0];
//    window = [app.windows elementBoundByIndex:0];
    //6秒后消失
    [window pressForDuration:6];
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testCustomKeyboard{
    //光标点击这个方法中，然后点击下面的红色圆点按钮，自动启动程序，点击界面元素会自动生成代码
    //注意中文会变成unicode编码，需手动修改
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"HqDatePickerVC"]/*[[".cells.staticTexts[@\"HqDatePickerVC\"]",".staticTexts[@\"HqDatePickerVC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeUp];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"HqKVOTestVC"]/*[[".cells.staticTexts[@\"HqKVOTestVC\"]",".staticTexts[@\"HqKVOTestVC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeUp];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"HqKeyboardUseVC"]/*[[".cells.staticTexts[@\"HqKeyboardUseVC\"]",".staticTexts[@\"HqKeyboardUseVC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.textFields[@"请输入"] tap];
    [app.buttons[@"1"] tap];
    [app.buttons[@"2"] tap];
    [app.buttons[@"3"] tap];
    [app.buttons[@"4"] tap];
    [app.buttons[@"5"] tap];
    [app.buttons[@"6"] tap];
    [app.buttons[@"完成"] tap];
    [app.navigationBars[@"HqKeyboardUseVC"].buttons[@"nav back"] tap];
    
}

@end
