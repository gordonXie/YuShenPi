//
//  NaviView.h
//  YuShenPi
//
//  Created by xieguocheng on 14-11-14.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviItem : NSObject
@property (nonatomic) NSString *itemTitle;
@property (nonatomic) NSMutableArray *itemActions;
@end


@protocol NaviViewDelegate <NSObject>
- (void)onItemClick:(NSDictionary*)dic;
@end


@interface NaviView : UIView
@property (nonatomic) NSString *naviTitle;
@property (nonatomic) NSMutableArray *itemArray;
@property (nonatomic) id<NaviViewDelegate> delegate;

- (void)resetNaviView;
- (void)closeNaviView;
@end
