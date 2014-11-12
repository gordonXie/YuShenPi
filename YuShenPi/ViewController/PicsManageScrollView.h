//
//  PicsManageScrollView.h
//  CustomAPP
//
//  Created by xieguocheng on 14-8-28.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    PicScrollViewCustom = 1,        //常规样式，控制标示在右下  默认
    PicScrollViewMiddle = 2         //控制标示在中间
}PicScrollViewType;

typedef enum
{
    PicScrollData_HotNews   = 1,
    PicScrollData_HotCoupon = 2,
    PicScrollData_HotAd     = 3,
    PicScrollData_Local     = 4
}PicScrollDataType;

@protocol PicScrollViewDelegate <NSObject>
- (void)onPicSelectByIndex:(int)index;
@end


@interface PicsManageScrollView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) NSObject<PicScrollViewDelegate> *picDelegate;
@property (nonatomic) PicScrollViewType picViewType;
@property (nonatomic) PicScrollDataType picDataType;
@property (nonatomic) BOOL isTimeShow;         //定时滚动显示
@end
