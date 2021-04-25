#import <UIKit/UIKit.h>

@class MyTabBar;

//MyTabBar的代理必须实现addButtonClick，以响应中间“+”按钮的点击事件
@protocol MyTabBarDelegate <NSObject>

-(void)centerButtonClick:(MyTabBar *)tabBar;

@end

@interface MyTabBar : UITabBar

//指向MyTabBar的代理
@property (nonatomic,weak) id<MyTabBarDelegate> myTabBarDelegate;

@end
