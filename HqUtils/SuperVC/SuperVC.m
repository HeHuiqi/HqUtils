//
//  SuperVC.m
//  HHQ
//
//  Created by iMac on 15/6/8.
//  Copyright (c) 2015年 HHQ. All rights reserved.
//

#import "SuperVC.h"
#define kNetworkStatus @"kNetworkStatus"
@interface SuperVC ()
@property (nonatomic,strong) UIImage *bottomLineImage;
@property (nonatomic,strong) UIImage *origalBottomImage;

@end

@implementation SuperVC

#pragma mark - 这里处理在切换controller时导航条的变化
- (void)viewControllerReset{
    
    //获取上一个导航的状态然后重新赋值
    self.isAlphaZeroNavBar = self.isAlphaZeroNavBar;
    [self _setNavBar];
    self.isShowBottomLine = self.isShowBottomLine;
    [self _setBottomLine];
    self.navbarCorlor = self.navbarCorlor;
    [self _setBarColor];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewControllerReset];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navbarCorlor =[UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_networkState:) name:kNetworkStatus object:nil];

    [self titelLab];
    
    self.isAlphaZeroNavBar = NO;
    self.isShowBottomLine = YES;

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtnImageName = @"nav_back";
    self.leftBtn.tintColor = HqBarBtnTintColor;
    self.leftBtn.frame = CGRectMake(0, 0, 50, 44);
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //当导航控制器的的控制器数为0即根控制器时，隐藏返回键
    if (self.navigationController.viewControllers.count==1) {
        
        self.navigationItem.leftBarButtonItem = nil;
    }else{
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
        item.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = item;
    }
    self.origalBottomImage = self.navigationController.navigationBar.shadowImage;
}
#pragma mark Title
- (void)setTitle:(NSString *)title{
    self.titelLab.text = title;
    [self.titelLab sizeToFit];
}

- (UILabel *)titelLab{
    if (!_titelLab) {
        _titelLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _titelLab.textAlignment = NSTextAlignmentCenter;
        _titelLab.textColor = HqTitleColor;
        _titelLab.font = [UIFont boldSystemFontOfSize:HqTitleFontsize];
        self.navigationItem.titleView = _titelLab;
    }
    return _titelLab;
}

#pragma mark - left、right按钮相关
- (void)setLeftBtn:(UIButton *)leftBtn{
    if (leftBtn) {
        _leftBtn = leftBtn;
    }
    [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setLeftBtnImageName:(NSString *)leftBtnImageName{

    NSString *fielPath = [[NSBundle mainBundle] pathForResource:leftBtnImageName ofType:@"png"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fielPath]) {
        UIImage *image = [UIImage imageNamed:leftBtnImageName];
        [_leftBtn setImage:image forState:UIControlStateNormal];
    }else{
//        HqString *str = [[HqString alloc] initWithHqString:leftBtnImageName];
//        [str setHqFont:SetFont(50) range:NSMakeRange(0, 1)];
//        [_leftBtn setAttributedTitle:str.hqAttributedString forState:UIControlStateNormal];
        [_leftBtn setTitle:leftBtnImageName forState:UIControlStateNormal];

    }
}

- (void)setRightBtn:(UIButton *)rightBtn{
    _rightBtn = rightBtn;
    if (rightBtn) {
        [_rightBtn removeFromSuperview];
        _rightBtn = rightBtn;
//        _rightBtn.frame = CGRectMake(0, 0, kZoomValue(50), 44);
        [_rightBtn sizeToFit];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.navigationItem.rightBarButtonItem = [self barItemWithView:_rightBtn];
    }
}
- (UIBarButtonItem *)barItemWithView:(UIView *)view{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}
- (void)setRightBtnImageName:(NSString *)rightBtnImageName{
    
    NSString *fielPath = [[NSBundle mainBundle] pathForResource:rightBtnImageName ofType:@"png"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fielPath]) {
        UIImage *image = [UIImage imageNamed:rightBtnImageName];
        [_rightBtn setImage:image forState:UIControlStateNormal];
    }else{
        [_rightBtn setTitle:rightBtnImageName forState:UIControlStateNormal];
    }
}


#pragma mark - NavBar
- (CGFloat )navBarHeight{
    BOOL device = IS_iPhoneX;
    CGFloat barHeight = 64;
    if (device) {
        barHeight = 88;
    }
    return barHeight;
}
- (CGFloat)tabBarheight{
    BOOL device = IS_iPhoneX;
    CGFloat barHeight = 50;
    if (!device) {
        barHeight = 84;
    }
    return barHeight;
}
- (void)setNavbarCorlor:(UIColor *)navbarCorlor{
    _navbarCorlor = navbarCorlor;
}
- (void)_setBarColor{
    if (self.navbarCorlor) {
        self.navigationController.navigationBar.barTintColor = self.navbarCorlor;

    }else{
        self.navigationController.navigationBar.barTintColor = nil;
    }
}
#pragma mark - NavBarBgBiew //这里可以做透明度的渐变
- (UIView *)navBarBgView{
    if (!_navBarBgView) {
        _navBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.navBarHeight)];
    }
    return _navBarBgView;
}
#pragma mark - NavBarBottomLine
- (void)_setBottomLine{
    if (self.isShowBottomLine) {
        self.bottomLineImage = self.bottomLineImage;
    }else{
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }
}
#pragma mark - AlphaZeroNavBar
- (void)setIsAlphaZeroNavBar:(BOOL)isAlphaZeroNavBar{
    _isAlphaZeroNavBar = isAlphaZeroNavBar;
    if (_isAlphaZeroNavBar) {
        self.isShowBottomLine = NO;
    }else{
//        self.isShowBottomLine = YES;
    }
}
- (void)_setNavBar{
    if (self.isAlphaZeroNavBar) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - setBottomLineColor

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    
    UIImage *image = [self imageWithColor:_bottomLineColor];
    if (image) {
        self.bottomLineImage = image;
        
    }else{
        self.bottomLineImage = self.origalBottomImage;
        
    }
}
- (void)setBottomLineImage:(UIImage *)bottomLineImage{
    _bottomLineImage = bottomLineImage;
    self.navigationController.navigationBar.shadowImage = _bottomLineImage;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat lineWidth = 1.0/scale;
    return [self imageWithColor:color size:CGSizeMake(lineWidth, lineWidth)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//- (HqNoNetworkView *)noNetworkView{
//    if (!_noNetworkView) {
//        _noNetworkView = [[HqNoNetworkView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.tabBarheight)];
//        _noNetworkView.style = 2;
//        _noNetworkView.hidden = YES;
//    }
//    return _noNetworkView;
//}
#pragma mark - 网络状态变化
- (void)_networkState:(NSNotification *)notifi{
    int status = [notifi.object intValue];
    [self networkState:status];
}
- (void)networkState:(int)status{
    
};

#pragma mark - Push
- (void)pushWithLastVC:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [vc.navigationController pushViewController:self animated:YES];
}
#pragma mark - 返回事件
-(void)backClick
{
    if (self.navigationController.viewControllers.count>0) {
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)backToVC:(NSString *)vcName{
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(vcName)]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
