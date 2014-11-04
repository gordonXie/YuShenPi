//
//  GuideViewController.h
//  NewYiPai
//
//  Created by 李恒 on 13-5-6.
//  Copyright (c) 2013年 李恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBaseViewController.h"

@interface GuideViewController : JBaseViewController<UIScrollViewDelegate>
{
    UIScrollView *mScroll_view;
}

@property(nonatomic,retain)UIScrollView *scroll_view;

@end
