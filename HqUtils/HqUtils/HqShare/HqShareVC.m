//
//  HqShareVC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/26.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqShareVC.h"

@interface HqShareVC ()

@end

@implementation HqShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)share{
    NSString *textToShare = @"我是iOS开发者，欢迎关注我！";
    UIImage *imageToShare = [UIImage imageNamed:@"san_jiao"];
    NSURL *urlToShare = [NSURL URLWithString:@"https://github.com/HeHuiqi"];
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
//    UIActivity *activi = [[UIActivity alloc]init];

    // NSPhotoLibraryAddUsageDescription 注意添加访问相册的key
    UIActivityViewController *acV = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    acV.excludedActivityTypes = @[UIActivityTypeMail,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    acV.excludedActivityTypes = @[UIActivityTypePostToTwitter,UIActivityTypePostToWeibo];
    acV.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError){
        NSLog(@"activityType :%@", activityType);
        if (completed)
        {
            if ([activityType isEqualToString:UIActivityTypeSaveToCameraRoll]) {
                NSLog(@"保存成功");
            }
            NSLog(@"completed");
        }
        else
        {
            NSLog(@"cancel");
        }
    };
    [self presentViewController:acV animated:YES completion:nil];
    
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
