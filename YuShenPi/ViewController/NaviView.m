//
//  NaviView.m
//  YuShenPi
//
//  Created by xieguocheng on 14-11-14.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "NaviView.h"

@implementation NaviItem
@synthesize itemTitle,itemActions;

@end

const float baseViewW = 240.0;
const float baseViewH = 300.0;
const float titleH = 34.0;
const float tableCellH = 40.0;
@interface NaviView ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_baseView;
    NSInteger    _currentItemIndex;
    UITableView *_tableView;
    UITableView *_itemTableView;
}

@end
@implementation NaviView
@synthesize naviTitle,itemArray,delegate;

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        itemArray = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return self;
    
}
- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor grayColor];
    self.alpha = 0.7;
    
    _baseView  =[[UIView alloc]initWithFrame:CGRectMake((rect.size.width-baseViewW)/2.0, (rect.size.height-baseViewH)/2.0, baseViewW, baseViewH)];
    _baseView.backgroundColor = [UIColor blueColor];
    _baseView.alpha = 1.0;
    [self addSubview:_baseView];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, baseViewW, titleH)];
    titleLbl.text = naviTitle;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:20.0];
    [_baseView addSubview:titleLbl];
    
    [self addTableView];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleH, baseViewW/2.0-5, baseViewH-titleH)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_baseView addSubview:_tableView];
    
    _itemTableView = [[UITableView alloc]initWithFrame:CGRectMake(baseViewW/2.0+5, titleH, baseViewW/2.0-5, baseViewH-titleH)];
    _itemTableView.backgroundColor = [UIColor clearColor];
    _itemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _itemTableView.dataSource = self;
    _itemTableView.delegate = self;
    [_baseView addSubview:_itemTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_itemTableView) {
        return ((NaviItem*)[itemArray objectAtIndex:_currentItemIndex]).itemActions.count;
    }else
        return itemArray.count;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableCellH;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdentify = @"identify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdentify];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tableCellH-2, baseViewW/2.0-5, 2)];
        [lineImgView setImage:[UIImage imageNamed:@"tableCellline@2x"]];
        [cell.contentView addSubview:lineImgView];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];

    if (tableView==_itemTableView) {
        NaviItem *item = (NaviItem*)[itemArray objectAtIndex:_currentItemIndex];
        cell.textLabel.text = [item.itemActions objectAtIndex:indexPath.row];
    }else{
        NaviItem *item = (NaviItem*)[itemArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@>",item.itemTitle];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (tableView==_itemTableView) {
        if (delegate&&[delegate respondsToSelector:@selector(onItemClick:)]) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_currentItemIndex],@"itemIndex",[NSString stringWithFormat:@"%d",indexPath.row ],@"subItemIndex", nil];
            [delegate onItemClick:dic];
            [self closeNaviView];
        }
    }else{
        _currentItemIndex = indexPath.row;
        [_itemTableView reloadData];
        
        if (_currentItemIndex==5) {//退出NaviView
            [self closeNaviView];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
}

//重置
- (void)resetNaviView
{
    if (_tableView) {
//        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        _currentItemIndex = 0;
        [_tableView reloadData];
        
        [_itemTableView reloadData];
    }
}

- (void)closeNaviView
{
    if (_tableView) {
        [self resetNaviView];
        self.hidden = YES;
    }
}
@end
