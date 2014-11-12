//
//  ServiceListItemCell.h
//  YuShenPi
//
//  Created by xieguocheng on 14-11-12.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBaseViewController.h"

@interface ServiceListItemCell : UITableViewCell
@property (nonatomic) NSString *cellTitle;
@property (nonatomic) ServiceCellWindowType windowType;
@property (nonatomic) UIViewController *ownerVC;
@end
