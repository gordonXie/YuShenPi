//
//  JPurpose.h
//  Youyi
//  意向
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPPForm.h"

@interface JPurpose : NSObject
{
    NSUInteger      *_id;           //意向编号      从101开始，100之前为预留编号
    NSString        *_name;         //名称   (1-9个字符)
    NSString        *_action;       //意向达成时的动作名称，在意向界面中心显示，用来展示个性(1-2个字符)
    NSMutableArray  *_memberArray;  //意向成员
    NSDate          *_date;         //意向时间  还需考虑
    NSString        *_description;  //意向描述

    JPPForm         *_ppForm;       //意向达成情况回顾表单
}
@end
