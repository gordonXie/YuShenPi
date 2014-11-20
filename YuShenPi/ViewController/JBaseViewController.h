//
//  JBaseViewController.h
//  jiajia
//
//  Created by xieguocheng on 14-6-9.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toast+UIView.h"
#import "MBProgressHUD.h"
#import "XCommon.h"
#import "GlobalConfig.h"
#import "AppDelegate.h"
#import "MarkedWordsConfig.h"
#import "NetWebServiceRequest.h"
#import "GDataXMLNode.h"
#import "SoapXmlParseHelper.h"

#define  kTopBtnSize  34.0f
#define  kBackBtnFrame CGRectMake(10.0f, (NAVBAR_HEIGHT-26.0)/2.0, 37.5, 26.0)
#define  kViewEdgeSize    10.0f

typedef enum{
    KCellWindowType_Gongshang = 0,
    KCellWindowType_Zhijian,
    KCellWindowType_Guoshui,
    KCellWindowType_Gongan
}ServiceCellWindowType;

@interface JBaseViewController : UIViewController<MBProgressHUDDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIImageView *titleView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,assign) NSUInteger statusBarH;
@property(nonatomic,strong) MBProgressHUD *m_loading;
@property (nonatomic,strong) NetWebServiceRequest* runningRequest;

//初始化界面元素
- (void)initViews;
//设置标题
- (void)setTitle:(NSString*)title;
//添加导航返回按钮
- (void)addBackBtn;
//添加导航左按钮
- (void)addLeftBtnWithImg:(UIImage*)btnImg selectImg:(UIImage*)selImg;
- (void)addLeftBtn:(NSString*)title;
//添加导航右按钮
- (void)addRightBtnWithImg:(UIImage*)btnImg selectImg:(UIImage*)selImg;
- (void)addRightBtn:(NSString*)title;

//添加等待提示
- (void)hudShowWithLabel:(NSString*) labelText;
- (void)hudHidden;

- (void)backBtnClick:(id)sender;

- (void)onLeftBtnClick:(id)sender;
- (void)onRightBtnClick:(id)sender;
- (UIButton*)getLeftBtn;
- (UIButton*)getRightBtn;

- (BOOL)shouldAutorotate;

- (NSUInteger)supportedInterfaceOrientations;

//添加单击手势
- (void)addSingleTouch;
@end


@interface JBaseViewController (NetRequest)<NetWebServiceRequestDelegate>
- (void)checkNetwork;
- (void)requestResultAnalytic:(id)responseObject;
//添加无数据提示
- (void)addNoDataView;
- (void)addNoDataViewWithText:(NSString*)text;
- (void)removeNoDataView;
//联网失败
- (void)netFailureWithError:(NSError*)error;
- (void)loginTimeout;
@end


#pragma mark - 数据库存储聊天记录
typedef enum _EMsgType
{
    KMsgFromOthers  = 0,         //我收到的消息
    KMsgFromMe      = 1          //我发出的消息
}EMsgFromType;

//@interface JBaseViewController (DataBase)
////创建数据库
//- (FMDatabase*)createDB;
//- (BOOL)clearDBTable;
////存储未上传的数据在本地
//- (BOOL)saveDataAtLocal:(id)dataDic forType:(EMsgFromType)msgFromType withTime:(NSString*)time;
//- (BOOL)saveImgDataAtLocal:(id)images forType:(EMsgFromType)saveType withTime:(id)time;
////获取当前时间
//-(NSString *)getDateTimehmsString;
//@end
