//
//  UIImage+Size.m
//  CustomAPP
//
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "UIImage+Size.h"

#define IOSOVER8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

@implementation UIImage (Size)
- (CGSize)getSize
{
    CGSize size = self.size;
    if (IOSOVER8) {
        size.height = size.height*2;
        size.width = size.width*2;
    }
    return size;
}
@end
