//
//  HqRegExVC.m
//  HqUtils
//
//  Created by hqmac on 2019/1/4.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqRegExVC.h"
#import "HqRegEx.h"

@interface HqRegExVC ()

@end

@implementation HqRegExVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regexTest];

}


- (void)regexTest{
    
    NSString *key = @"name";
    //获取url参数，这里是获取name参数的值
    NSString *text = @"name=jike&age=12";
    NSString *regex = [NSString stringWithFormat:@"name=[^&]*"];
    
    NSArray *atMatchs =   [self findString:text regexString:regex];
      for (NSTextCheckingResult *match in atMatchs) {
          NSString *matchStr = [text substringWithRange:match.range];
          NSLog(@"matchStr:%@",matchStr);
          matchStr = [matchStr substringFromIndex:key.length+1];
          NSLog(@"matchStr:%@",matchStr);
      }
}

- (void)regexAllTest{
    //    [HqRegEx extractStr];
        
        NSString *text = @"1942年春<a href='https://lichang.tag?id=59919&type=1'>@木心夕啊 </a>我的家乡#河南#发生了#吃的问题#人民大量逃荒";
    //    text = @"小丽说:您好吗@小花 \n小明说:我很好";
        
        NSString *regex = @"#[*]#";
        //解析# #
        regex = @"#[\\u4e00-\\u9fa5\\w\\-\\_|【|】]+#";
        //解析超链接
        regex = @"href='(.*?)'";

    //    regex = @"<a href=(?:.*?)>(.*?)<\\/a>";
    //    NSArray *linkMatchs =   [self findString:text regexString:regex];
    //      for (NSTextCheckingResult *match in linkMatchs) {
    //          NSString *matchStr = [text substringWithRange:match.range];
    //          NSLog(@"matchStr===%@",matchStr);
    //          NSString *link = [matchStr substringWithRange:NSMakeRange(6, matchStr.length-7)];
    //          NSLog(@"link===%@",link);
    //          NSDictionary *queryDic = [NSString queryParamsFormatUrlString:link];
    //          NSLog(@"queryDic==%@",queryDic);
    //
    //      }
        
        //解析# #
        regex = @"#[\\w]+#";
        
        //解析@
        regex = @"@[\\w]+ ";

        text = @"";
        regex = @"#.*?#";
        
        text = @"今天的天气不错@【您好】 一起去爬山吧！";
        regex = @"@.*? ";


        NSArray *atMatchs =   [self findString:text regexString:regex];
          for (NSTextCheckingResult *match in atMatchs) {
              NSString *matchStr = [text substringWithRange:match.range];
              NSLog(@"matchStr===%@",matchStr);
          }
        NSMutableString *mstr = [[NSMutableString alloc] initWithString:text];;
        [mstr replaceOccurrencesOfString:regex withString:@"#名字#" options:(NSRegularExpressionSearch) range:NSMakeRange(0, mstr.length)];
        NSLog(@"mstr==%@",mstr);
    //    //解析——:
    //    regex = @"[\\w]+:";
    //  NSArray *matchs =   [self findString:text regexString:regex];
    //    for (NSTextCheckingResult *match in matchs) {
    //        NSString *matchStr = [text substringWithRange:match.range];
    //        NSLog(@"matchStr===%@",matchStr);
    //    }
        
        
        regex = @"margin[-]*[left | right | top | bottom ]*[: ]*\\d*[px]*[ !important]*;*";
        text = @"left: 10px; margin-bottom:10;margin:10px; margin-left: 900px !important; margin-top:   10px; padding-left: 100;";
        text = [text stringByReplacingOccurrencesOfString:regex withString:@"" options:(NSRegularExpressionSearch) range:NSMakeRange(0, text.length)];
        NSLog(@"text===%@",text);
        
        regex = @"\\{.*\\}";
        text = @"欢迎{name}观赏！";
        [self findString:text regexString:regex];
        text = [text stringByReplacingOccurrencesOfString:regex withString:@"手机" options:NSRegularExpressionSearch range:NSMakeRange(0, text.length)];
        NSLog(@"text===%@",text);
}

- (NSArray<NSTextCheckingResult *> *)findString:(NSString *)string regexString:(NSString *)regexString
{
    // 找到文本中所有的@
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, [string length])];
    NSLog(@"matches==%@",matches);
    return matches;
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
