//
//  HqColorImageVC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/18.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqColorImageVC.h"
#import "HqColorImage.h"
@interface HqColorImageVC ()

@end

@implementation HqColorImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 150, 50)];
    UIImage *image = [HqColorImage imageWithColor:[UIColor redColor] isBorder:YES];
    UIImage *himage = [HqColorImage imageWithColor:[UIColor blueColor] isBorder:NO];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:himage forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)+10, 150, 50)];
    [btn1 setTitle:@"登录" forState:UIControlStateNormal];
    UIImage *image1 = [HqColorImage imageWithColor:[UIColor blueColor] isBorder:NO];
    UIImage *himage1 = [HqColorImage imageWithColor:[UIColor redColor] isBorder:YES];
    [btn1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [btn1 setBackgroundImage:himage1 forState:UIControlStateHighlighted];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn1];
    
    UILabel *waringInfoLab = [[UILabel alloc] init];
    waringInfoLab.textAlignment = NSTextAlignmentCenter;
    waringInfoLab.backgroundColor = [UIColor redColor];
    NSString *waring = @"12345\n67890";
    waringInfoLab.numberOfLines = 0;
    NSMutableAttributedString *atrs = [[NSMutableAttributedString alloc] initWithString:waring];
//    [atrs addAttribute:NSWritingDirectionAttributeName value:@(
//     NSWritingDirectionLeftToRight | NSTextWritingDirectionEmbedding) range:NSMakeRange(0, 3)];
    waringInfoLab.frame = CGRectMake(20, CGRectGetMaxY(btn1.frame)+20, waringInfoLab.font.pointSize*10, 100);
    [self.view addSubview:waringInfoLab];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
//    paragraphStyle.lineSpacing = 15.f;
    // 段落间距
//    paragraphStyle.paragraphSpacing = 30.f;
    // 段落缩进像素
//    paragraphStyle.firstLineHeadIndent = 40.f;
    // 整体缩进像素
//    paragraphStyle.headIndent = 15.f;
    // 对齐方式
    paragraphStyle.alignment = NSTextAlignmentLeft;
    // 其他属性请自行查阅NSMutableParagraphStyle头文件

    [atrs addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, 3)];
   
    waringInfoLab.attributedText = atrs;
//    waringInfoLab.text = waring;

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
