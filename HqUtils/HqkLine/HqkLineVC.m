//
//  HqkLineVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/6.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqkLineVC.h"
#import "HqkLineUtils.h"

#import "HqTradeTrendView.h"

@interface HqkLineVC ()

@property(nonatomic,strong) HqTradeTrendView *tradeTrendView;

@end

@implementation HqkLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tradeTrendView = [[HqTradeTrendView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, kZoomValue(300))];
    [self.view addSubview:self.tradeTrendView];
    
////    HqPointModel *model0 = [HqPointModel initPositon:0 yPosition:80];
////
////    HqPointModel *model = [HqPointModel initPositon:20 yPosition:50];
////    HqPointModel *model2 = [HqPointModel initPositon:40 yPosition:100];
////
////    HqPointModel *model3 = [HqPointModel initPositon:80 yPosition:150];
////    HqPointModel *model4 = [HqPointModel initPositon:100 yPosition:30];
//
//    self.tradeTrendView.datas = @[model0,model,model2,model3,model4];
    
    
//    self.tradeTrendView.backgroundColor = [UIColor redColor];
    [self.tradeTrendView.segmentControl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self segmentChange:self.tradeTrendView.segmentControl];

}
- (void)segmentChange:(UISegmentedControl *)segmentControl{
    NSInteger limit = 365;
    NSString *type = @"day";
    switch (segmentControl.selectedSegmentIndex) {
        case 1:
            type = @"minute";
            limit = 24*60;
            break;
        case 2:
            type = @"hour";
            limit = 7*24;
            break;
        case 3:
            type = @"hour";
            limit = 30*24;
            break;
            
        default:
            break;
    }
    NSDictionary *params = @{@"tokenid":@"12",
                              @"type":type,
                              @"limit":@(limit)};
    [self requestKLineDatasWithParams:params];
}
- (void)requestKLineDatasWithParams:(NSDictionary *)params{
    
    [HqHttpUtil hqGet:params url:@"http://192.168.1.102:9000/v3/kline/getLineData" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dataDic = [responseObject hq_objectForKey:@"data"];
        NSArray *list = [dataDic hq_objectForKey:@"list"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            HqklineShowModel *showModel = [HqkLineUtils dealKlineDatas:list showViewHeight:kZoomValue(200)];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tradeTrendView.klineShowModel = showModel;
            });
        });
    }];
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
