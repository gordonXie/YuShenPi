//
//  UITextField+LabelAndImage.m
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "UITextField+LabelAndImage.h"

@implementation UITextField (LabelAndImage)
- (void)setLeftImage:(UIImage*)image
{
    //    self.borderStyle = UITextBorderStyleRoundedRect;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (image) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
        [leftBtn setImage:image forState:UIControlStateNormal];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [leftBtn setEnabled:NO];
        self.leftView = leftBtn;
    }else{
        UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        self.leftView = leftView;
    }
}

- (void)setLeftLabelWithText:(NSString*)text
{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (text) {
        float fontSize = 16.0;
        float length = [self widthForString:text fontSize:fontSize];
        
        UILabel *leftLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, length, 20)];
        leftLbl.backgroundColor = [UIColor clearColor];
        leftLbl.font = [UIFont systemFontOfSize:fontSize];
        leftLbl.text = text;
        self.leftView = leftLbl;
    }else{
        UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        self.leftView = leftView;
    }
}

- (void)setLeftSpace:(float)space
{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, space, 5)];
    self.leftView = leftView;
}

- (void)setLeftSpace
{
    [self setLeftSpace:5];
}

- (float) widthForString:(NSString *)value fontSize:(float)fontSize
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

@end
