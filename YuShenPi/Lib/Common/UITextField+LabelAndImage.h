//
//  UITextField+LabelAndImage.h
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LabelAndImage)
- (void)setLeftImage:(UIImage*)image;
- (void)setLeftLabelWithText:(NSString*)text;
- (void)setLeftSpace;
- (void)setLeftSpace:(float)space;
@end
