//
//  HqBoxImageViewVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqBoxImageViewVC.h"

#import "HqNineBoxView.h"

@interface HqBoxImageViewVC ()

@property(nonatomic,strong) HqNineBoxView *boxImageView;

@end

@implementation HqBoxImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boxImageView = [[HqNineBoxView alloc] initWithFrame:CGRectMake(kZoomValue(12), 100, SCREEN_WIDTH-kZoomValue(24), SCREEN_HEIGHT-100)];
    self.boxImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.boxImageView];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",@"",@"",@"",@""];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",@"",@"",@""];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",@"",@"",];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",@"",];
//    self.boxImageView.imageDatas = @[@"",@"",@"",@"",];
    self.boxImageView.imageDatas = @[@"",@"",@""];
//    self.boxImageView.imageDatas = @[@"",@""];
//    self.boxImageView.imageDatas = @[@""];

    CGRect bounds = self.boxImageView.frame;
    bounds.size.height = self.boxImageView.boxHeight;
    self.boxImageView.frame = bounds;

    
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
