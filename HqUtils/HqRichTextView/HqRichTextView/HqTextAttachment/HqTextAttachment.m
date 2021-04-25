//
//  HqTextAttachment.m
//  HqRichTextEditorDemo
//
//  Created by hehuiqi on 2020/4/23.
//  Copyright © 2020 hehuiqi. All rights reserved.
//

#import "HqTextAttachment.h"

@implementation HqTextAttachment


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
    [aCoder encodeObject:self.localPath forKey:@"localPath"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeCGRect:self.bounds forKey:@"bounds"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        self.urlString = [aDecoder decodeObjectForKey:@"urlString"];
        self.localPath = [aDecoder decodeObjectForKey:@"localPath"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.bounds = [aDecoder decodeCGRectForKey:@"bounds"];

    }
    return self;
}
@end


