//
//  NSData+UTF_8.m
//  jiajia
//
//  Created by xieguocheng on 14-6-24.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "NSData+UTF_8.h"

@implementation NSData (UTF_8)
- (NSString *)toUTF8String
{
    NSString * result = [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding] ;
    return result;
}
@end
