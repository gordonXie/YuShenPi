//
//  JMember.h
//  Youyi
//  成员
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMember : NSObject
{
    NSInteger *_id;             //成员编号
    NSString  *_name;           //成员名称
    NSString  *_headUrl;        //成员头像url
    NSMutableArray *_ppArray;   //成员参加的意向
}
@end
