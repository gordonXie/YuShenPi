//
//  JBaseViewController.m
//  jiajia
//
//  Created by xieguocheng on 14-6-9.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JBaseViewController.h"
#import "AppDelegate.h"
#import "AFNetWorking.h"

#define KLeftBtnTag  49
#define KRightBtnTag 50

@interface JBaseViewController ()
{
    MBProgressHUD *m_loading;
}
@end

@implementation JBaseViewController
@synthesize titleView,titleLabel;
@synthesize statusBarH;
@synthesize m_loading;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    statusBarH = 0;
    if ([[[UIDevice currentDevice ]systemVersion] integerValue]>=7) {
        self.view.bounds = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height );
        statusBarH = 20;
    }
    [self initViews];
}

- (void)initViews
{
    CGRect frame = self.view.bounds;
    frame.size.height = NAVBAR_HEIGHT+statusBarH;
    titleView = [[UIImageView alloc] initWithFrame:frame];
    titleView.userInteractionEnabled = YES;
    [self.view addSubview:titleView];
    
    frame.origin = CGPointMake((SCREEN_WIDTH - 240)/2, statusBarH);
    frame.size = CGSizeMake(240, NAVBAR_HEIGHT);
    titleLabel = [[UILabel alloc] initWithFrame:frame];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:21.0f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
}
//设置标题
- (void)setTitle:(NSString*)title
{
    self.titleLabel.text = title;
}
//添加返回按钮
- (void)addBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = kBackBtnFrame;
//    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_back_normal@2x",appDelegate.configInfo.colorType]] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_back_selected@2x",appDelegate.configInfo.colorType]] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)backBtnClick:(id)sender
{
    [appDelegate.navController popViewControllerAnimated:YES];
}

//添加导航左按钮
- (void)addLeftBtnWithImg:(UIImage*)btnImg selectImg:(UIImage*)selImg;
{
    [self addLeftBtn:nil];
    UIButton *leftBtn = [self getLeftBtn];
    [leftBtn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:selImg forState:UIControlStateHighlighted];
}
- (void)addLeftBtn:(NSString *)title
{
    UIButton *leftBtn = (UIButton*)[self.view viewWithTag:KLeftBtnTag];
    if (leftBtn == nil) {
        leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        leftBtn.frame = CGRectMake(10 , (NAVBAR_HEIGHT-kTopBtnSize)/2.0,kTopBtnSize, kTopBtnSize);
        [leftBtn setTitle:title forState:UIControlStateNormal];
        leftBtn.layer.cornerRadius = 10; //圆形按钮的半径
        leftBtn.tag = KLeftBtnTag;
        [leftBtn addTarget:self action:@selector(onLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:leftBtn];
    }
}

- (void)onLeftBtnClick:(id)sender
{
    
}

- (UIButton*)getLeftBtn
{
    UIButton *btnLeft = (UIButton*)[self.view viewWithTag:KLeftBtnTag];
    return btnLeft;
}

//添加导航右按钮
- (void)addRightBtnWithImg:(UIImage*)btnImg selectImg:(UIImage*)selImg;
{
    [self addRightBtn:nil];
    UIButton* btnRight = [self getRightBtn];
    [btnRight setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btnRight setBackgroundImage:selImg forState:UIControlStateHighlighted];
}
- (void)addRightBtn:(NSString *)title
{
    UIButton *btnRight = (UIButton*)[self.view viewWithTag:KRightBtnTag];
    if (btnRight==nil) {
        btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRight.frame = CGRectMake(self.view.bounds.size.width - 10 - kTopBtnSize , (NAVBAR_HEIGHT-kTopBtnSize)/2.0,kTopBtnSize, kTopBtnSize);
        btnRight.layer.cornerRadius = 10; //圆形按钮的半径
        btnRight.tag = KRightBtnTag;
        [btnRight setTitle:title forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(onRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnRight];
    }
}

- (void)onRightBtnClick:(id)sender
{
    
}

- (UIButton*)getRightBtn
{
    UIButton *btnRight = (UIButton*)[self.view viewWithTag:KRightBtnTag];
    return btnRight;
}

#pragma mark FLProgressHUDDelegate methods
- (void)hudShowWithLabel:(NSString*) labelText{
    
    if (m_loading == nil) {
        NSLog(@"%@",[UIApplication sharedApplication]);
        NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
        m_loading = [[MBProgressHUD alloc] initWithView:self.view];
        [[UIApplication sharedApplication].keyWindow addSubview:m_loading];
        m_loading.delegate = self;
        
        //添加单击手势
//        UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudHidden)];
//        singleGesture.numberOfTapsRequired = 1;
//        singleGesture.numberOfTouchesRequired = 1;
//        singleGesture.delegate = self;
//        [m_loading addGestureRecognizer:singleGesture];
    }
    if (labelText==nil) {
        labelText = @"正在努力加载...";
    }
	m_loading.labelText = labelText;
    [m_loading show:YES];
}

- (void)hudHidden{
    if (m_loading==nil) {
        return;
    }
	[m_loading removeFromSuperview];
	m_loading = nil;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

//添加单击手势
- (void)addSingleTouch
{
    UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTouch:)];
    singleGesture.numberOfTapsRequired = 1;
    singleGesture.numberOfTouchesRequired = 1;
    singleGesture.delegate = self;
    [self.view addGestureRecognizer:singleGesture];
}

- (void)onSingleTouch:(id)sender
{
    
}
@end

@implementation JBaseViewController (NetRequest)
#pragma mark - 检查网络连接
- (void)checkNetwork
{
    if (![AFNetworkReachability checkNetworkConnectivity]) {
        [self.view makeToast:@"网络未连接"];
        return;
    }
}
#pragma mark - 解析数据请求结果
- (void)requestResultAnalytic:(id)responseObject
{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
    if (dic==nil) {  //json解析失败
        [XCommon showAlertWithTitle:@"错误提示" message:[NSString stringWithFormat:@"%@",error]];
    }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"result"])) {
        [self.view makeToast:[dic objectForKey:@"msg"]];
        
    }else{
        [XCommon showAlertWithTitle:@"错误提示" message:[dic objectForKey:@"msg"]];
    }
}
//添加无数据提示
- (void)addNoDataView
{
//    [self addNoDataViewWithText:KNoDataReturn];
}

- (void)addNoDataViewWithText:(NSString*)text
{
    UIView *noDataView = [self.view viewWithTag:KNODATAVIEWTAG];
    if (noDataView==nil) {
        float size = 200.0;
        noDataView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-size)/2, (SCREEN_HEIGHT-size)/2, size, size)];
        noDataView.tag = KNODATAVIEWTAG;
        [self.view addSubview:noDataView];
        
        float imgSize = 70.0;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((size-imgSize)/2, 0, imgSize, imgSize)];
        [imgView setImage:[UIImage imageNamed:@"noData@2x"]];
        [noDataView addSubview:imgView];
        
        UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, imgSize+10, size, 20)];
        textLbl.backgroundColor = [UIColor clearColor];
        textLbl.textAlignment = NSTextAlignmentCenter;
        textLbl.textColor = [UIColor grayColor];
        if (text==nil) {
//            textLbl.text = KNoDataReturn;
        }else
            textLbl.text = text;

        [noDataView addSubview:textLbl];
    }
    
    noDataView.hidden = NO;
}
- (void)removeNoDataView
{
    UIView *noDataView = [self.view viewWithTag:KNODATAVIEWTAG];
    if (noDataView!=nil) {
        [noDataView removeFromSuperview];
    }
}

//联网失败
- (void)netFailureWithError:(NSError*)error
{
    [self hudHidden];
    
    if(![XCommon isNullString:[[error userInfo] objectForKey:@"NSLocalizedDescription"]]){
        [XCommon showAlertWithTitle:@"错误提示" message:[NSString stringWithFormat:@"%@",[[error userInfo] objectForKey:@"NSLocalizedDescription"]]];
    }else{
        [XCommon showAlertWithTitle:@"错误提示" message:@"联网错误"];
    }
}
//登录超时
- (void)loginTimeout
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"登录超时，请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = KLOGINTIMEOUTALERTTAG;
    [alertView show];
}
@end


/*
@implementation JBaseViewController (DataBase)

//创建数据库
- (FMDatabase*)createDB
{
    //paths： ios下Document路径，Document为ios中可读写的文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MessageLogs.db"];
    //创建数据库实例 db  这里说明下:如果路径中不存在"MessageLogs.db"的文件,sqlite会自动创建"MessageLogs.db"
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    //    BOOL succ = [db executeUpdate:@"DROP TABLE SaveData"];
    BOOL succ = [db executeUpdate:@"CREATE TABLE SaveData (Time text,Name text,SaveType integer,SaveData text,Image blob)"];
    
    return db;
}

//清除数据库中的表
- (BOOL)clearDBTable
{
    FMDatabase *db = [self createDB];
    BOOL succ = [db executeUpdate:@"DROP TABLE SaveData"];
    
    return succ;
}

//存储聊天记录在本地
- (BOOL)saveDataAtLocal:(id)dataDic forType:(EMsgFromType)msgFromType withTime:(NSString*)time
{
    FMDatabase *db = [self createDB];
    
    BOOL isSuccess = [db executeUpdate:@"INSERT INTO SaveData (Time,Name,SaveType,SaveData) VALUES (?,?,?,?)",time,[XCommon UserDefaultGetValueFromKey:USERNAME],[NSNumber numberWithInt:msgFromType],dataDic ];
    return isSuccess;
}

- (BOOL)saveImgDataAtLocal:(id)images forType:(EMsgFromType)saveType withTime:(NSString*)time
{
    if(images==nil)
    {
        return NO;
    }
    
//    UIImage *image = (UIImage*)images;
//    NSData * imgData = nil;
//    if (image!=nil) {
//        imgData = UIImageJPEGRepresentation(image, .3);
//    }
    
    FMDatabase *db = [self createDB];
    BOOL isSuccess;

    isSuccess = [db executeUpdate:@"INSERT INTO SaveData (Time,Name,SaveType,SaveData,Image) VALUES (?,?,?,?,?)",time,[XCommon UserDefaultGetValueFromKey:USERNAME],[NSNumber numberWithInt:saveType],@"",images];
    
    return isSuccess;
}

//获取当前时间
-(NSString *)getDateTimehmsString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

@end
*/