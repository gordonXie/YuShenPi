//
//  HomeViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    UIScrollView    *_baseScrollView;
    NSMutableArray  *_purposeArray;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"预审批系统"];
    [self addLeftBtn:@"返回"];
    [self addRightBtn:@"导航"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    [self initPurposeArray];
    //添加"意向"
    [self addPurposes];
}
- (void)initPurposeArray
{
    _purposeArray = [[NSMutableArray alloc]initWithCapacity:5];
    [_purposeArray addObject:@"学习"];
    [_purposeArray addObject:@"塑身"];
    [_purposeArray addObject:@"存钱"];
}
- (void)addPurposes
{
    
}
#pragma mark - 添加意向
- (void)addNewPurpose
{
    
}

- (void)onRightBtnClick:(id)sender
{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
