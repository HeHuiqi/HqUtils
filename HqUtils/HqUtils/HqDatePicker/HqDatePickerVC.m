//
//  HqDatePickerVC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/25.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqDatePickerVC.h"

#import "WSDatePickerView.h"
#define RGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

#define randomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

@interface HqDatePickerVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dateStyles;
@end

@implementation HqDatePickerVC
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateStyles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dateStyles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectAction:indexPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *initDate = @[@"年-月-日-时-分",@"月-日-时-分",@"年-月-日",@"年-月",@"月-日",@"时-分",@"年",@"月",@"指定日期2011-11-11 11:11",@"日-时-分"];
    self.dateStyles = [[NSMutableArray alloc] initWithArray:initDate];
    [self.view addSubview:self.tableView];
    
    
}
- (void)reloadIndex:(NSIndexPath *)indexPath dateStr:(NSString *)dateStr{
    NSString *lastDate = self.dateStyles[indexPath.row];
    [self.dateStyles removeObject:lastDate];
    [self.dateStyles insertObject:dateStr atIndex:indexPath.row];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)selectAction:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            //年-月-日-时-分
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
                
            }];
//            datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
//            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
//            datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
            [datepicker show];
        }
            break;
        case 1:
        {
            //月-日-时-分
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"MM-dd HH:mm"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = [UIColor purpleColor];//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = [UIColor purpleColor];//确定按钮的颜色
            [datepicker show];
            
        }
            break;
        case 2:
        {
            //年-月-日
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
        }
            break;
        case 3:
        {
            //年-月
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
            
        }
            break;
        case 4:
        {
            //月-日
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"MM-dd"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
            
        }
            break;
        case 5:
        {
            //时-分
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"HH:mm"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            datepicker.yearLabelColor = [UIColor cyanColor];//大号年份字体颜色
            [datepicker show];
            
        }
            break;
        case 6:
        {
            //年
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYear CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"yyyy"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
        }
            break;
        case 7:
        {
            //月
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonth CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"MM"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
        }
            break;
        case 8:
        {
            //指定日期2011-11-11 11:11
            NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
            [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *scrollToDate = [minDateFormater dateFromString:@"2011-11-11 11:11"];
            
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
                NSLog(@"选择的日期：%@",date);
                [self reloadIndex:indexPath dateStr:date];
                
            }];
            datepicker.dateLabelColor = RGB(65, 188, 241);//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = RGB(65, 188, 241);//确定按钮的颜色
            datepicker.hideBackgroundYearLabel = YES;//隐藏背景年份文字
            [datepicker show];
        }
            break;
        case 9:
        {
            //日-时-分
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"dd HH:mm"];
                NSLog(@"选择的日期：%@",dateString);
                [self reloadIndex:indexPath dateStr:dateString];
            }];
            datepicker.dateLabelColor = randomColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = randomColor;//滚轮日期颜色
            datepicker.doneButtonColor = randomColor;//确定按钮的颜色
            [datepicker show];
        }
            break;
        default:
            break;
    }
    
    
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
