//
//  XCommon.h
//  PlayWhat
//
//  Created by 谢  on 13-4-23.
//  Copyright (c) 2013年 fljt. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface XCommon : NSObject
/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (float) widthForString:(NSString *)value fontSize:(float)fontSize;
//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;

//MD5加密
+ (NSString *)md5:(NSString *)str;
//URLEncode编码
+ (NSString *)URLEncodedString:(NSString *)sourceString;
+ (NSString *)urlEncodedString:(NSData *)src;
//判断一个字符串是否为空
+ (BOOL)isNullString:(NSString *)string;
//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
//读写文件
+(void)UserDefaultSetValue:(id)value forKey:(NSString *)key;
+(id)UserDefaultGetValueFromKey:(NSString *)key;
//获取当前时间
+(NSString *)getDateTimeString;
+(NSString *)getDateString;
//计算时间差
+(double)GetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE;
//由字符串生成字典
+(NSDictionary *)creatDicWithString:(NSString *)str;
//保持图片到沙盒
+(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName;
//从沙盒读取图片
+(UIImage*)getImageFromFileByName:(NSString*)imageName;
//字符串转化成日期
+(NSDate*)dateFromString:(NSString*)dateString;
//比较时间 -1小于  0等于   1大于
+(int)dateCompare:(NSDate*)startDate endDate:(NSDate*)endDate;

//显示Alert
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

/*
 * 定位
 */
// 定义经纬度结构体
typedef struct {
    double lng;
    double lat;
} Location;

//inline Location
+(Location)LocationMake:(double)lng withLat:(double) lat;

//地球坐标和火星坐标转换
//苹果得到的是 WGS84坐标;
//谷歌地图API，高德地图API，腾讯地图API上取到的，都是GCJ-02坐标；
//百度API上取到的，是BD-09坐标
//WGS84坐标 转换成 GCJ-02坐标
+(void)locationTransformWithwgLat:(double) wgLat withwgLon:(double)wgLon whitmgLat:(double*)mgLat whitmgLat:(double*) mgLon;
/*
*  GCJ-02 坐标转换成 BD-09 坐标
*/
+ (Location) bd_encrypt:(Location) gcLoc;

/*
*  BD-09 坐标转换成 GCJ-02坐标
*/
+ (Location) bd_decrypt:(Location) bdLoc;

//判断邮箱格式
+ (BOOL) validateEmail:(NSString *)email;
// 获得图片类型
+ (NSString *)typeForImageData:(NSData *)data;

//程序版本
+ (NSString *)versionStringDisplay;

//解析经纬度字符串  "40.343434,129.394884"
+ (CLLocationCoordinate2D)location2DByString:(NSString*)locStr;

//距离转换，返回的是单位是米，分千米和米两种单位显示，小于1000米，则显示米
+ (NSString*)distanceByMeter:(NSString *)meterDis;

//强制转换屏幕
+(void)setViewOrientation:(UIInterfaceOrientation )orientation;

//计算文件夹下文件的总大小
+(long)fileSizeForDir:(NSString*)path;
// 删除图片缓存
+ (BOOL) deleteDirInCache:(NSString *)dirName;
@end
