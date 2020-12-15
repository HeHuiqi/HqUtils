//
//  UIControl+HqClickAnalysis.m
//  HqUtils
//
//  Created by hehuiqi on 2020/2/20.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "UIControl+HqClickAnalysis.h"
#import "MethodSwizzingTool.h"
#import "HqCodeVC.h"

@implementation UIControl (HqClickAnalysis)



+(void)load
{
    /*
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzingSelector = @selector(user_sendAction:to:forEvent:);
        [MethodSwizzingTool swizzingForClass:[self class] originalSel:originalSelector swizzingSel:swizzingSelector];
    });
    */
}

-(void)user_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self user_sendAction:action to:target forEvent:event];
    
    NSString * identifier = [NSString stringWithFormat:@"%@/%@/%ld", [target class], NSStringFromSelector(action),self.tag];
    NSLog(@"identifier==%@",identifier);
    NSLog(@"target==%@",target);

//    HqCodeVC *codeVC = target;
//    NSLog(@"---codeVC===%@",codeVC.title);
    /*
    NSDictionary * dic = [[[DataContainer dataInstance].data objectForKey:@"ACTION"] objectForKey:identifier];
    if (dic) {
        
        NSString * eventid = dic[@"userDefined"][@"eventid"];
        NSString * targetname = dic[@"userDefined"][@"target"];
        NSString * pageid = dic[@"userDefined"][@"pageid"];
        NSString * pagename = dic[@"userDefined"][@"pagename"];
        NSDictionary * pagePara = dic[@"pagePara"];
        __block NSMutableDictionary * uploadDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [pagePara enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            id value = [CaptureTool captureVarforInstance:target withPara:obj];
            if (value && key) {
                [uploadDic setObject:value forKey:key];
            }
        }];
        
        
        NSLog(@" \n  唯一标识符为 : %@, \n event id === %@,\n  target === %@, \n  pageid === %@,\n  pagename === %@,\n pagepara === %@ \n", identifier, eventid, targetname, pageid, pagename, uploadDic);
    }
    */
}

@end
