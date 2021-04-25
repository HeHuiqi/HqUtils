#import "HqCustomTabBarVC.h"
#import "MyTabBar.h"

#import "HqCodeVC.h"
#import "HqTabHomeVC.h"
#import "HqTabCenterVC.h"
#import "HqTabMyVC.h"
#import "HqCustomTabBar.h"
@interface HqCustomTabBarVC () <MyTabBarDelegate> //实现自定义TabBar协议

@end

@implementation HqCustomTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers =  @[[HqTabHomeVC new],[HqTabCenterVC new],[HqTabMyVC new]];

    // Do any additional setup after loading the view.

    //设置TabBar上第一个Item（明细）选中时的图片
    UIImage *listActive = [UIImage imageNamed:@"tab1"];
    UITabBarItem *listItem = self.tabBar.items[0];
    listItem.title = @"tab1";
    //始终按照原图片渲染
    UIImage *tab1Image = [listActive imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    listItem.selectedImage = tab1Image;
    listItem.image = tab1Image;


    //设置TabBar上第二个Item（报表）选中时的图片
    UIImage *chartActive = [UIImage imageNamed:@"tab2"];
    UITabBarItem *chartItem = self.tabBar.items[1];
    chartItem.title = @"tab2";

//    //始终按照原图片渲染
//    UIImage *tab2Image =  [chartActive imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    chartItem.selectedImage = tab2Image;
//    chartItem.image = tab2Image;
    
    
    
    UIImage *chartActive1 = [UIImage imageNamed:@"tab3"];
    UITabBarItem *chartItem1 = self.tabBar.items[2];
    chartItem1.title = @"tab3";
    UIImage *tab3Image =  [chartActive1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    chartItem1.selectedImage = tab3Image;
    chartItem1.image = tab3Image;


//    //创建自定义TabBar
//    MyTabBar *myTabBar = [[MyTabBar alloc] init];
//    myTabBar.myTabBarDelegate = self;
//    //利用KVC替换默认的TabBar
//    [self setValue:myTabBar forKey:@"tabBar"];
    
    
    //创建自定义TabBar
    HqCustomTabBar *myTabBar = [[HqCustomTabBar alloc] init];
    //利用KVC替换默认的TabBar
    [self setValue:myTabBar forKey:@"tabBar"];
    self.selectedIndex = 0;

}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //设置TabBar的TintColor
    self.tabBar.tintColor = [UIColor colorWithRed:89/255.0 green:217/255.0 blue:247/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - MyTabBarDelegate
-(void)centerButtonClick:(MyTabBar *)tabBar{
    //测试中间“+”按钮是否可以点击并处理事件
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"test" message:@"Test" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"test" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];

}

@end
