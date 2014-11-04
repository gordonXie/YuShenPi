//
//  UIView+SuperView.h
//  Marketing
//
//  Created by xie on 14-4-11.
//  Copyright (c) 2014年 谢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SuperView)
- (UIView *)findSuperViewWithClass:(Class)superViewClass;

@end
