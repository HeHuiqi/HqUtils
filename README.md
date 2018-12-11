# HqUtils
## [简书主页]( https://www.jianshu.com/u/b37773b21ff3)

## 项目简介
此项目是一个iOS开发工具集合的项目，相当于一个开发工具箱，项目中包含了
iOS开发中常用的的工具类和一些UI组件

## 部分列举如下：
* HqAlertView 一个以block方式的系统提示（iOS8.0+）
* HqImage UImage的一个类别
* Network 是一个网络请求工具类，包好系统和AFNetworking的封装
* HqPullZoomView 下拉放大视图
* HqCustomKeyboard、HqKeyBoard 自定义键盘
* HqDateFormatter 字符串日期各式转换，方便快捷
* HqDeviceInfo 获取设备信息的一个工具类
* HqEncrypt 加密类
* HqRichString 一个富文本工具类
* HqTextInputLimit 输入框字符限制类别
* HqKeyChain 钥匙串的简单操作
* Hq3DTouch 3DTouch的使用
* HqPlayer  视频播放器组件
* HqLoopView  无限轮播组件

## HqCustomKeyboard
```
Useage1:
UITextField *input  = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 200, 50)];
input.placeholder = @"请输入";
[self.view addSubview:input];
[self tapView:self.view];
HqKeyBoard *board = [HqKeyBoard new];
board.deleteImage = [UIImage imageNamed:@"delete"];
board.cancelImage = [UIImage imageNamed:@"resign"];
input.inputView = board;
board.tf = input;

Useage2:
UITextField *input2  = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(input.frame)+20, 200, 50)];
input2.placeholder = @"请输入2";
[self.view addSubview:input2];
input2.KeyBoardStyle = TextFiledKeyBoardStyleMoney;

```
