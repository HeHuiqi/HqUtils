//
//  HqTableViewTestVC.m
//  HqUtils
//
//  Created by hehuiqi on 7/1/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTableViewTestVC.h"
#import "HqShortArticleCell.h"
#import "HqShortArticle.h"
#import "HqTestCell.h"

#import "HqShareShortArticleView.h"
#import "HqTitleView.h"

#import "HqRichTextCell2.h"

@interface HqTableViewTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HqTitleView *titleView;

@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HqShareShortArticleView *shareView;
@property (nonatomic,strong) UIImageView *showImageView;



@end

@implementation HqTableViewTestVC

- (HqShareShortArticleView *)shareView{
    if (!_shareView) {
        _shareView = [[HqShareShortArticleView alloc] initWithFrame:CGRectMake(15, self.navBarHeight, SCREEN_WIDTH-30, SCREEN_HEIGHT-self.navBarHeight)];
    }
    return _shareView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.shareView];
    self.title = @"title";
    
    self.datas = [[NSMutableArray alloc] initWithCapacity:4];
    NSString *t0 = @"哈树<a href='https://lichang.tag?id=123&type=1'>@大家好</a>";
    NSString *t1 = @"哈是的噶说都快噶说谁根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的三个哈树<a href='https://user.profile.com?id=123'>@大家好</a> <a href='https://user.profile.com?id=456'>@大家好1</a>大根深大手都快";
    NSString *t2 = @"谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三噶说";
    NSString *t3 = @"谁都看过哈树大根深<a href='https://user.profile.com?id=789'>@大家好2</a>大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的噶说都快噶说谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的噶说都快噶说谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的噶说都快噶说谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都<a href='https://user.profile.com?id=345'>@大家好3</a>刚好洒蛋糕啊都快三个哈是的噶说都快噶说谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的噶说都快噶说谁都看过哈树大根深大手都快噶说根深蒂固看啥都干撒都刚好洒蛋糕啊都快三个哈是的噶说都快噶说";

//    for (int i = 0; i<20; i++) {
//        [self.datas addObject:@""];
//    }
    [self.datas addObjectsFromArray:@[t0]];

    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    [self.datas addObjectsFromArray:@[t1,t2,t3]];
    

//    [self.datas addObject:t0];
    [self initView];
    
    self.showImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.showImageView];
    self.showImageView.hidden = YES;
    
    self.titleView = [[HqTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.titleView.titleLab.text = @"我的标题";
    self.titleView.userIcon.image = [UIImage imageNamed:@"longmao.jpeg"];
    self.titleView.scollView = self.tableView;
    self.navigationItem.titleView = self.titleView;
    
    
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
//        _tableView.rowHeight = kZoomValue(150);
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    static NSString *cellId = @"cell";
//    HqTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (!cell) {
//        cell = [[HqTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//    return cell;
    
    static NSString *cellId = @"HqRichTextCell";
    HqRichTextCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
      cell = [[HqRichTextCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

//    NSAttributedString *atrs = [self htmlConvertStringRemoveImgTag:self.datas[indexPath.row]];
////    [self converToHtml:atrs];
//    cell.contentTv.attributedText = atrs;
    cell.content = self.datas[indexPath.row];
    
    return cell;
}
#pragma mark - testTextView
- (void)converToHtml:(NSAttributedString *)attributeString{
    NSDictionary *documentAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSData *htmlData = [attributeString dataFromRange:NSMakeRange(0, attributeString.length) documentAttributes:documentAttributes error:NULL];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
//    NSLog(@"htmlString==%@",htmlString);
}
#pragma mark - html字符串转文本
- (NSAttributedString *)htmlConvertStringRemoveImgTag:(NSString *)noImgTagHtmlStr{
    NSData *data = [noImgTagHtmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attStr.length)];
//    NSLog(@"attStr==%@",attStr);
    return attStr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
    

}




@end
