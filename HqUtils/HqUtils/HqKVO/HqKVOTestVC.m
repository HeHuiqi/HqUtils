//
//  HqKVOTestVC.m
//  HqTestDemo
//
//  Created by hqmac on 2019/2/25.
//  Copyright © 2019 HHQ. All rights reserved.
//

#import "HqKVOTestVC.h"
#import "HqKVO.h"
#import "HqUser.h"

#import "HqNotification.h"
@interface HqKVOTestVC ()

@property (nonatomic,strong) HqNotification *hqNotify;

@property (nonatomic,strong) HqKVO *hqKVO;
@property (nonatomic,strong) HqUser *user;

@end

@implementation HqKVOTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [[HqUser alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.user.name = @"Check";
    self.user.age = 10;
    
    HqKVO *hqKVO = [[HqKVO alloc] init];
    self.hqKVO= hqKVO;
    [hqKVO hq_addObserver:self.user keyPath:@"name" callback:^(NSString * _Nonnull keyPath, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSLog(@"keyPath==%@",keyPath);
        NSLog(@"change==%@",change);
    }];
    [hqKVO hq_addObserver:self.user keyPath:@"age" callback:^(NSString * _Nonnull keyPath, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSLog(@"age-keyPath==%@",keyPath);
        NSLog(@"age-change==%@",change);
    }];
    
    
    //通知测试
    self.hqNotify = [[HqNotification alloc] init];
    [self.hqNotify hqOberverNotifyName:@"kNotifyRefresh"  callBack:^(id  _Nonnull params) {
        NSLog(@"---params == %@",params);
    }];
    
   
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.user.name = @"Owen";
    self.user.age = 30;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotifyRefresh" object:@"哈哈哈"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
