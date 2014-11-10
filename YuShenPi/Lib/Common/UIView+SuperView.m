//
//  UIView+SuperView.m
//  Marketing
//
//  Created by xie on 14-4-11.
//  Copyright (c) 2014年 谢. All rights reserved.
//

#import "UIView+SuperView.h"

@implementation UIView (SuperView)
- (UIView *)findSuperViewWithClass:(Class)superViewClass {
    
    UIView *superView = self.superview;
    UIView *foundSuperView = nil;
    
    while (nil != superView && nil == foundSuperView) {
        if ([superView isKindOfClass:superViewClass]) {
            foundSuperView = superView;
        } else {
            superView = superView.superview;
        }
    }
    return foundSuperView;
}
@end
