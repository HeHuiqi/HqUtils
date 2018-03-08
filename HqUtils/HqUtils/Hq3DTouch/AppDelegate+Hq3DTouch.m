//
//  AppDelegate+Hq3DTouch.m
//  RuntimeUse
//
//  Created by macpro on 2018/3/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "AppDelegate+Hq3DTouch.h"

@implementation AppDelegate (Hq3DTouch)

//在iOS9.0及以上可用
- (void)add3DTouchItems:(UIApplication *)application{
   
    //给App图标添加3D Touch菜单
    //拍照
    
    //菜单图标
    UIApplicationShortcutIcon *iconCamera = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    //菜单文字
    UIMutableApplicationShortcutItem *itemCamera = [[UIMutableApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"拍照"];
    //绑定信息到指定菜单
    itemCamera.icon = iconCamera;
    
    //相册
    //菜单图标
    UIApplicationShortcutIcon *iconPhotoLibrary = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    //菜单文字
    UIMutableApplicationShortcutItem *itemPhotoLibrary = [[UIMutableApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"相册"];
    //绑定信息到指定菜单
    itemPhotoLibrary.icon = iconPhotoLibrary;
    
    UIMutableApplicationShortcutItem *openItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"3" localizedTitle:@"打开"];
    openItem.localizedSubtitle = @"文件详情";
    openItem.icon = nil;
    //绑定到App icon
    application.shortcutItems = @[itemCamera,itemPhotoLibrary,openItem];
    
}
//UIApplicationDelegate 在AppDelegate中处理处理点击的item
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    NSLog(@"UIApplicationShortcutItem == %@",shortcutItem);
}

@end
