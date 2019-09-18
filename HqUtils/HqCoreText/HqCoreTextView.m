//
//  HqCoreTextView.m
//  HqUtils
//
//  Created by hehuiqi on 8/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCoreTextView.h"
#import <CoreText/CoreText.h>

@implementation HqCoreTextView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    [self baseTextDraw];
//    [self baseGraphicsTextDraw];
    [self baseGraphicsTextLineDraw];

    
}
- (void)baseGraphicsTextLineDraw{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 20, self.bounds.size.height-20);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    CFStringRef str = CFSTR("门梁真可怕 当中英文混合之后，😊😊😊😊😊😊😊会出现行高不统一的情况，现在在绘制的时候根据字体的descender来偏移绘制，对齐baseline。🐱🐱🐱🐱🐱🐱🐱🐱同时点击链接的时候会调用drawRect: 造成绘制异常，所以将setNeedsDisplay注释，如需刷新，请手动调用。带上emoji以供测试🐶🐶🐶🐶🐶🐶🐶");
        str = CFSTR("门梁真可怕 当中英文混合之后，会出现行高不统一的情况，现在在绘制的时候根据字体的descender来偏移绘制，对齐baseline。同时点击链接的时候会调用drawRect: 造成绘制异常，所以将setNeedsDisplay注释，如需刷新，请手动调用。带上emoji以供测试🐶🐶🐶🐶🐶🐶🐶");

    CFAllocatorRef alloc = CFAllocatorGetDefault();
    CFIndex maxLength = 0;
    CFMutableAttributedStringRef attributeStr = CFAttributedStringCreateMutable(alloc, maxLength);
    CFAttributedStringReplaceString(attributeStr, CFRangeMake(0, 0), str);
    
    //设置字体
    CTFontRef allfont = CTFontCreateWithName(CFSTR(""), 17, NULL);
    CFAttributedStringSetAttribute(attributeStr, CFRangeMake(0, CFStringGetLength(str)), kCTFontAttributeName, allfont);
    
    //设置颜色
    CGColorRef color = [UIColor orangeColor].CGColor;
    CFAttributedStringSetAttribute(attributeStr, CFRangeMake(0, 12), kCTForegroundColorAttributeName, color);
    
    //设置字体
//    CTFontRef font = CTFontCreateWithName(CFSTR(""), 20, NULL);
//    CFAttributedStringSetAttribute(attributeStr, CFRangeMake(0, 12), kCTFontAttributeName, font);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect pathRect = self.bounds;
    pathRect = CGRectMake(0, 0, self.bounds.size.width-40, self.bounds.size.height-40);
    CGPathAddRect(path, NULL, pathRect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, pathRect);
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributeStr);
    CFRelease(attributeStr);
    
    CFIndex length = CFStringGetLength(str);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, length), path, NULL);
    
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint origins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    //
    if (self.drawWay == 0) {
        for (int i = 0; i<lineCount; i++) {
            CGPoint lineOrigin = origins[i];
            CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
            //设置每行的坐标
            CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
            //一行一行绘制
            CTLineDraw(lineRef, context);
            
            
            CGRect lineBounds = CTLineGetImageBounds(lineRef, context);
            lineBounds.origin.x = lineOrigin.x;
//            lineBounds.origin.y = lineOrigin.y;
            
//            lineBounds.origin.x = lineOrigin.x;
//            lineBounds.origin.y = lineOrigin.y;
            //填充
            CGContextSetLineWidth(context, 1.0);
            CGContextAddRect(context,lineBounds);
            CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
            CGContextStrokeRect(context, lineBounds);
            
        }
       
        NSLog(@"单行绘制");
    }else{
        //开始绘制
        
        for (int i = 0; i<lineCount; i++) {
            CGPoint lineOrigin = origins[i];
            CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
            //设置每行的坐标
            CGRect lineBounds = CTLineGetImageBounds(lineRef, context);
            lineBounds.origin.x += lineOrigin.x;
            lineBounds.origin.y += lineOrigin.y;
            if (i == 2) {
                CFArrayRef runs  = CTLineGetGlyphRuns(lineRef);
                CFIndex runCount = CFArrayGetCount(runs);
                CFRange lineRange =  CTLineGetStringRange(lineRef);
                NSLog(@"lineRange==%ld,%ld",lineRange.location,lineRange.length);
                CFIndex  glyphCount = CTLineGetGlyphCount(lineRef);
                CGFloat secondaryOffset;
                CTLineGetOffsetForStringIndex(lineRef, 2, &secondaryOffset);
                NSLog(@"secondaryOffset==%@",@(secondaryOffset));
                NSLog(@"glyphCount==%ld",glyphCount);
                CGFloat points1[runCount-1];
                CFURLRef runRef = CFArrayGetValueAtIndex(runs, runCount-1);
                CFIndex ii =   CTLineGetStringIndexForPosition(lineRef, CGPointMake(0, lineRange.length));
            
                NSLog(@"ponti == %ld",ii);
            }
          
            //填充
            CGContextSetLineWidth(context, 1.0);
            CGContextAddRect(context,lineBounds);
            CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
            CGContextStrokeRect(context, lineBounds);
            
        }
        NSLog(@"整体绘制");
        CTFrameDraw(frame, context);
    }
  

    
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
    
    
    
    
}

- (void)baseGraphicsTextDraw{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 20, self.bounds.size.height-20);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    CFStringRef str = CFSTR("门梁真可怕 当中英文混合之后，😊😊😊😊😊😊😊会出现行高不统一的情况，现在在绘制的时候根据字体的descender来偏移绘制，对齐baseline。🐱🐱🐱🐱🐱🐱🐱🐱同时点击链接的时候会调用drawRect: 造成绘制异常，所以将setNeedsDisplay注释，如需刷新，请手动调用。带上emoji以供测试🐶🐶🐶🐶🐶🐶🐶");
    CFAllocatorRef alloc = CFAllocatorGetDefault();
    CFIndex maxLength = 0;
    CFMutableAttributedStringRef attributeStr = CFAttributedStringCreateMutable(alloc, maxLength);
    CFAttributedStringReplaceString(attributeStr, CFRangeMake(0, 0), str);
    
    //设置颜色
    CGColorRef color = [UIColor orangeColor].CGColor;
    CFAttributedStringSetAttribute(attributeStr, CFRangeMake(0, 12), kCTForegroundColorAttributeName, color);
    
    //设置字体
    CTFontRef font = CTFontCreateWithName(CFSTR(""), 20, NULL);
    CFAttributedStringSetAttribute(attributeStr, CFRangeMake(0, 12), kCTFontAttributeName, font);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect pathRect = self.bounds;
    pathRect = CGRectMake(0, 0, 200, 200);
    CGPathAddRect(path, NULL, pathRect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, pathRect);
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributeStr);
    CFRelease(attributeStr);

    CFIndex length = CFStringGetLength(str);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, length), path, NULL);
    //开始绘制
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
    
    
    
    
}
- (void)baseTextDraw{
    // 步骤1：得到当前用于绘制画布的上下文，用于后续将内容绘制在画布上
    // 因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤2：翻转当前的坐标系（因为对于底层绘制引擎来说，屏幕左下角为（0，0））
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    //CGFloat tx, CGFloat ty 设置坐标系的远点位置
    CGContextTranslateCTM(context, 20, self.bounds.size.height-20);
    //反转坐标系
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤3：创建NSAttributedString
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"iOS程序在启动时会创建一个主线程，而在一个线程只能执行一件事情，如果在主线程执行某些耗时操作，例如加载网络图片，下载资源文件等会阻塞主线程（导致界面卡死，无法交互），所以就需要使用多线程技术来避免这类情况。iOS中有三种多线程技术 NSThread，NSOperation，GCD，这三种技术是随着IOS发展引入的，抽象层次由低到高，使用也越来越简单。"];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attrString.length)];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 8;
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attrString.length)];
    
    
    // 步骤4：根据NSAttributedString创建CTFramesetterRef
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    // 步骤5：创建绘制区域CGPathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect pathRect = self.bounds;
    pathRect = CGRectMake(0, 0, 200, 200);
    CGPathAddRect(path, NULL, pathRect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, pathRect);
    
    //    CGPathAddEllipseInRect(path, NULL, self.bounds);
    //    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //    CGContextFillEllipseInRect(context, self.bounds);
    //
    // 步骤6：根据CTFramesetterRef和CGPathRef创建CTFrame；
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attrString length]), path, NULL);
    
    //获取CTLineRef个数
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    //获取基准原点
    CGPoint origins[lineCount];
    //这里range为取决于path的bounds的位置
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    for (CFIndex i = 0; i<lineCount; i++) {
        //取得其中一行
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        //获取这一行的Bounds
        CGRect lineBounds = CTLineGetImageBounds(lineRef, context);
        NSLog(@"lineBounds = %@",NSStringFromCGRect(lineBounds));
        NSLog(@"point = %@",NSStringFromCGPoint(origins[i]));
        //每一行的起点（相对于context）加上相对于本身基线原点的偏移量
        lineBounds.origin.x += origins[i].x;
        lineBounds.origin.y += origins[i].y;
        //绘制line的边框
        CGContextSetLineWidth(context, 1.0);
        CGContextAddRect(context, lineBounds);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextStrokeRect(context, lineBounds);
    }
    
    
    
    // 步骤7：CTFrameDraw绘制
    CTFrameDraw(frame, context);
    // 步骤8.内存管理
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}


- (void)baseOpt{
    // Drawing code
    //因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    NSString *CTMStr = @"";
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CTMStr = NSStringFromCGAffineTransform(CGContextGetCTM(context));
    NSLog(@"当前context的变换矩阵 %@",CTMStr);
    
    //翻转当前的坐标系（因为对于底层绘制引擎来说，屏幕左下角为（0，0））
    //设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    
    CGAffineTransform TransformID = CGAffineTransformIdentity;
    CGContextSetTextMatrix(context, TransformID);
    CTMStr = NSStringFromCGAffineTransform(CGContextGetCTM(context));
    NSLog(@"context的初始矩阵 %@",CTMStr);
    
    //开始变换1
    //CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    //CGContextConcatCTM(context, flipVertical);//将当前context的坐标系进行flip
    
    //开始变换2
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTMStr = NSStringFromCGAffineTransform(CGContextGetCTM(context));
    NSLog(@"翻转后context的变换矩阵 %@",CTMStr);
    
}

@end

