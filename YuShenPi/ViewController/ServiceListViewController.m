//
//  ServiceListViewController.m
//  YuShenPi
//
//  Created by xieguocheng on 14-11-12.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ServiceListViewController.h"
#import "ServiceListItemCell.h"

#define KTABLECELLHEIGHT 160.0

@interface ServiceListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_tableArray;
}

@end

@implementation ServiceListViewController
@synthesize windowType;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    
    [self setViewTitle];
    [self addBackBtn];
    [self addRightBtn:@"导航"];
    
    [self addTableView];
}

- (void)setViewTitle
{
    switch (windowType) {
        case KCellWindowType_Gongshang:
            [self setTitle:@"工商窗口服务列表"];
            break;
        case KCellWindowType_Zhijian:
            [self setTitle:@"质监窗口服务列表"];
            break;
        case KCellWindowType_Guoshui:
            [self setTitle:@"国税窗口服务列表"];
            break;
        case KCellWindowType_Gongan:
            [self setTitle:@"公安窗口服务列表"];
            break;
            
        default:
            break;
    }
}

- (void)addTableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
        _tableArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdentify = @"identify";
    
    ServiceListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    if (cell==nil) {
        cell = [[ServiceListItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdentify];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.cellTitle = @"神九发射的分开睡多久";
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KTABLECELLHEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
