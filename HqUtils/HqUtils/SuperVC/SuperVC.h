//
//  SuperVC.h
//  XWF_iOS
//
//  Created by iMac on 15/6/8.
//  Copyright (c) 2015年 xwf_id. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HqSuperDefine.h"
@interface SuperVC : UIViewController


@property (nonatomic,strong) UIColor *navbarCorlor;//设置导航颜色
@property (nonatomic,assign) CGFloat navBarheight;//导航高度
@property (nonatomic,assign) CGFloat tabBarheight;

//导航view
@property (nonatomic,strong) UIView *navBarBgView;

@property (nonatomic,strong) UILabel *titelLab;

//左侧按钮,默认创建了一个按钮，也可以自己创建
@property (nonatomic,strong) UIButton *leftBtn;
//如果图片存在就设置为图片，不存在就设置为Title
@property (nonatomic,copy) NSString *leftBtnImageName;

//右侧按钮,默认没有创建可以自己创建设置相关属性
@property (nonatomic,strong) UIButton *rightBtn;
//如果图片存在就设置为图片，不存在就设置为Title
@property (nonatomic,copy) NSString *rightBtnImageName;

//默认为YES,设置NO时隐藏底部线
@property (nonatomic,assign) BOOL isShowBottomLine;

//底部线的颜色
@property (nonatomic,strong) UIColor *bottomLineColor;

//是否导航透明
@property (nonatomic,assign) BOOL isAlphaZeroNavBar;

//@property (nonatomic,strong) HqNoNetworkView *noNetworkView;

- (void)networkState:(int)status;

- (void)pushWithLastVC:(UIViewController *)vc;

-(void)backClick;
- (void)backToVC:(NSString *)vcName;

@end
