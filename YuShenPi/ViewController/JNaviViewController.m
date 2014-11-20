//
//  JNaviViewController.m
//  YuShenPi
//
//  Created by xieguocheng on 14-11-17.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JNaviViewController.h"
#import "NaviView.h"

@interface JNaviViewController ()<NaviViewDelegate>
{
    NaviView *_naviView;
}
@end

@implementation JNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self addRightBtnWithImg:[UIImage imageNamed:@"funbutton@2x.jpg"] selectImg:nil];
}

- (void)onRightBtnClick:(id)sender
{
    [self addNaviView];
}

#pragma mark - NaviView
- (void)addNaviView
{
    if (_naviView==nil) {
        _naviView = [[NaviView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _naviView.naviTitle = @"功能导航";
        _naviView.delegate = self;
        const int itemCount = 6;
        NSArray *titleArray = [[NSArray alloc]initWithObjects:@"首页",@"个人信息",@"规范指南",@"我的事项",@"政策咨询",@"关闭导航",nil];
        NSMutableArray *itemArray = [[NSMutableArray alloc]initWithCapacity:2];
        for (int i=0; i<itemCount; i++) {
            switch (i) {
                case 0:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"返回首页", nil];
                    [itemArray addObject:items];
                }
                    break;
                case 1:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"基本信息",@"退出登录", nil];
                    [itemArray addObject:items];
                }
                    break;
                    
                case 2:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"规范指南", nil];
                    [itemArray addObject:items];
                }
                    break;
                    
                case 3:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"未提交事项",@"已提交事项",@"已退回事项",@"已办结事项", nil];
                    [itemArray addObject:items];
                }
                    break;
                    
                case 4:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"政策咨询", nil];
                    [itemArray addObject:items];
                }
                    break;
                    
                case 5:
                {
                    NSArray *items = [[NSArray alloc]initWithObjects:@"", nil];
                    [itemArray addObject:items];
                }
                    break;
                    
                default:
                    break;
            }
        }
        for (int i=0;i<itemCount;i++){
            NaviItem *item = [[NaviItem alloc]init];
            item.itemTitle = [titleArray objectAtIndex:i];
            item.itemActions = [itemArray objectAtIndex:i];
            
            [_naviView.itemArray addObject:item];
        }
        [self.view addSubview:_naviView];
    }
    _naviView.hidden = NO;
}

#pragma mark - NaviViewDelegate
- (void)onItemClick:(NSDictionary*)dic
{
    //  NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_currentItemIndex],@"itemIndex",[NSString stringWithFormat:@"%d",indexPath.row ],@"subItemIndex", nil];
    NSInteger itemIndex = [[dic objectForKey:@"itemIndex"] integerValue];
    NSInteger subItemIndex = [[dic objectForKey:@"subItemIndex"] integerValue];
    
    switch (itemIndex) {
        case 0:
        {
            //返回首页
            [appDelegate.navController popToRootViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            if (subItemIndex==0) { //基本信息
                
            }else{ //退出登录
                
            }
        }
            break;
        case 2:
        {
            //规范指南
        }
            break;
        case 3:
        {
            if (subItemIndex==0) { //未提交事项
                
            }else if(subItemIndex==1){ //已提交事项
                
            }else if(subItemIndex==2){ //已退回事项
                
            }else{ //已办结事项
                
            }

        }
            break;
        case 4:
        {
            //政策咨询
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
