//
//  HqShortArticleVC.m
//  HqUtils
//
//  Created by hehuiqi on 7/2/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqShortArticleVC.h"
#import "HqShortArticleCell.h"
#import "HqShortArticle.h"

#import "HqShareShortArticleView.h"
@interface HqShortArticleVC ()<
UITableViewDelegate,UITableViewDataSource,
HqShortArticleCellDelegate>


@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIImageView *showImageView;
@property (nonatomic,strong) UIScrollView *imgScroolView;
@property (nonatomic,strong) HqShareShortArticleView *shareView;

@end

@implementation HqShortArticleVC

- (HqShareShortArticleView *)shareView{
    if (!_shareView) {
        _shareView = [[HqShareShortArticleView alloc] initWithFrame:CGRectMake(15, 88, SCREEN_WIDTH-30, SCREEN_HEIGHT-300)];
    }
    return _shareView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"title";
    [self.view addSubview:self.shareView];
    self.datas = [[NSMutableArray alloc] initWithCapacity:4];
    HqShortArticle *sa = [[HqShortArticle alloc] init];
    sa.open = NO;
    NSString *content = @"我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光啊我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光啊我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光啊我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光啊我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光我都会感觉到还是感觉啊是的可视电话噶精神的回归可恨的是感觉啊是的话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光话都是看过啊是的话都是关机哈收到过啊是看的噶好的时光啊";
    sa.content = content;
    
    content = @"我都会感觉到还是感觉啊是的可视电话噶精神我都会感觉到还是感觉啊是的可视电话噶精神2";
    HqShortArticle *sa1 = [[HqShortArticle alloc] init];
    sa1.open = NO;
    sa1.content = content;
    
    [self.datas addObject:sa];
    [self.datas addObject:sa1];
    
    [self initView];
    NSString *weak = [self weakDayWithDate:NSDate.new];
    NSLog(@"weak==%@",weak);
    
    UIScrollView *imgScroolView =[[ UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:imgScroolView];
    self.imgScroolView = imgScroolView;
    self.imgScroolView.hidden = YES;
    self.showImageView = [[UIImageView alloc] init];
//    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.backgroundColor = [UIColor blackColor];
    [self.imgScroolView addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgScroolView).offset(0);
         make.top.equalTo(self.imgScroolView).offset(0);
         make.bottom.equalTo(self.imgScroolView).offset(0);
        make.width.mas_equalTo(imgScroolView.bounds.size.width);
    }];

    
}
- (void)initView{
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, self.navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-self.navBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = kZoomValue(150);
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    HqShortArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HqShortArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    HqShortArticle *sa = self.datas[indexPath.row];
    cell.shortArticle = sa;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HqShortArticle *sa = self.datas[indexPath.row];
    sa.open = !sa.open;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - HqShortArticleCellDelegate 点击分享
- (void)hqShortArticleCell:(HqShortArticleCell *)cell clickShareBtn:(UIButton *)btn{
//    NSLog(@"点击分享==%@",cell.shortArticle.content);
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat originalH = self.shareView.bounds.size.height;
        CGFloat textH = [NSString getTextHeightWithString:cell.shortArticle.content fontSize:17 textWidth:SCREEN_WIDTH-60];
        CGFloat contentH = kZoomValue(220)+textH;
      
        dispatch_async(dispatch_get_main_queue(), ^{
            self.shareView.contentLab.text = cell.shortArticle.content;
            if (contentH>originalH) {
                self.shareView.mj_h = contentH;
            }
            UIImage *image = [UIImage getScreenshot:self.shareView];
            self.showImageView.image = image;
            self.imgScroolView.hidden = NO;
            self.shareView.mj_h = originalH;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.imgScroolView.hidden = YES;
            });

        });
    });
 
}

- (NSString *)weakDayWithDate:(NSDate *)date{
  
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


@end
