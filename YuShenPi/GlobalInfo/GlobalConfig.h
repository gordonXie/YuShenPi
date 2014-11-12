//
//  GlobalConfig.h
//  jiajia
//
//  Created by xieguocheng on 14-6-9.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//  全局配置

#ifndef jiajia_GlobalConfig_h
#define jiajia_GlobalConfig_h

#pragma mark - 基本信息
//#define KZFT_TEST    //测试
#define KAPPVersion   @"1.0"
#define KOSTYPE       @"02"      //ios

#pragma mark - 界面尺寸
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height - 20
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define NAVBAR_HEIGHT 44
#define CONTENT_HEIGHT  SCREEN_HEIGHT - NAVBAR_HEIGHT

//AppDelegate
#define appDelegate   ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//手机号
#define K_PHONE @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0123,5-9]))\\d{8}$"

//用户中心背景颜色
#define UCBGCOLOR [UIColor colorWithRed:231.0 green:235.0 blue:234.0 alpha:1.0]
#define KUserCenter_Bg_Color  @"#eeeff3"

//Tag定义
#define KNODATAVIEWTAG 240
#define KLISTLEFTIMAGETAG 250
#define KLOGINTIMEOUTALERTTAG 260

#pragma mark - netWork
#ifdef KZFT_TEST
//#define Base_URL @"http://192.168.171.114/jiajia_server/"
#define Base_URL @"http://10.6.144.3:8080/jiajia_server/"
#else
#define Base_URL @"http://api.jia.dtenga.com/jiajia_server/"

#endif

#define KPAGESIZE   @"10"
//服务器返回“0”，表示请求成功
#define IS_NETREQUEST_SUCCESS(result) [(result) isEqualToString:@"0"]
//服务器返回“1”，表示登录超时
#define IS_NETREQUEST_LOGIN_TIMEOUT(result) [(result) isEqualToString:@"1"]


//百度地图申请的key
#define KBAIDUMAPKEY @"7u66tWr05XHDFfIAB5dnVcBj"
//友盟加加key
#define KUMENGKEY    @"53be11bd56240bf04b0f320b"

#pragma mark - 本地存储字段
#define ARWITHTIP       @"ARWithTip"      //启动AR扫描弹出提示信息
#define ISLOGINKEY      @"isLogin"          //是否已登录   "1" 表示已登录
#define USERNAME        @"userName"         //用户名
#define PASSWORD        @"password"         //密码
#define USERINFO        @"userInfo"         //用户信息
#define SESSIONID       @"sessionID"        //sessionID
#define GuideStatus     @"guideStatus"      //引导页状态
#define REMEMBERPS      @"rememberPassword" //记住密码

#pragma mark - FontSize
#define KTableCellFontCommon  15.0
#define KTableCellFontBig     18.0
#define KTableCellFontSmall   12.0

#endif
