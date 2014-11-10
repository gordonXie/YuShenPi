//
//  NSString+Base64.m
//  StringsBuilder
//
//  Created by chenghxc on 13-2-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Base64.h"
#import "NSData+Base64.h"
@implementation NSString (Base64)

+ (NSString *)base64Encode:(NSString *)plainText
{
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

+ (NSString *)base64Decode:(NSString *)base64String
{
    NSData *plainTextData = [NSData dataFromBase64String:base64String];
    NSString *plainText = [[[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding] autorelease];
    return plainText;
}
@end
