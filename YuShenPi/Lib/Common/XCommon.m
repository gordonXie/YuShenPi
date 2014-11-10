//
//  XCommon.m
//  PlayWhat
//
//  Created by 谢  on 13-4-23.
//  Copyright (c) 2013年 fljt. All rights reserved.
//

#import "XCommon.h"
#import <math.h>

@implementation XCommon
/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

+ (float) widthForString:(NSString *)value fontSize:(float)fontSize
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//MD5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//URLEncode编码
+ (NSString *)URLEncodedString:(NSString *)sourceString
{
    NSData * UTF8Data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];

    NSString *encodedString = [self urlEncodedString:UTF8Data];
    return encodedString;
}


+ (NSString *)urlEncodedString:(NSData *)src
{
	char *hex = "0123456789ABCDEF";
	unsigned char * data = (unsigned char*)[src bytes];
	int len = [src length];
	NSMutableString* s = [NSMutableString string];
	for(int i = 0;i<len;i++){
		unsigned char c = data[i];
		if( ('a' <= c && c <= 'z')
		   || ('A' <= c && c <= 'Z')
		   || ('0' <= c && c <= '9') ){
			NSString* ts = [[NSString alloc] initWithCString:(char *)&c length:1];
			
			[s appendString:ts];
			[ts release];
		} else {
			[s appendString:@"%"];
			char ts1 = hex[c >> 4];
			NSString* ts = [[NSString alloc] initWithCString:&ts1 length:1];
			[s appendString:ts];
			[ts release];
			char ts2 = hex[c & 15];
			ts = [[NSString alloc] initWithCString:&ts2 length:1];
			[s appendString:ts];
			[ts release];
			
		}
	}
	return s;
}


//判断一个字符串是否为空
+ (BOOL)isNullString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//读写文件
+(void)UserDefaultSetValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)UserDefaultGetValueFromKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud valueForKey:key];
}

//获取当前时间
+(NSString *)getDateTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];

    return dateTime;
}
+(NSString *)getDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    return date;
}
//计算时间差
+(double)GetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE
{
    double timeDiff = 0.0;
    
    NSDateFormatter *formatters = [[NSDateFormatter alloc] init];
    [formatters setDateFormat:@"yyyy-MM-dd HH:mm"];   //@"yyyy/MM/dd HH:mm:ss:SSS"
    NSDate *dateS = [formatters dateFromString:timeS];
    
    NSDateFormatter *formatterE = [[NSDateFormatter alloc] init];
    [formatterE setDateFormat:@"yyyy-MM-dd HH:mm"];  //yyyy-MM-dd HH:mm
    NSDate *dateE = [formatterE dateFromString:timeE];
    
    timeDiff = [dateE timeIntervalSinceDate:dateS ];  //默认是秒
    
    return timeDiff/60.0;
}
//由字符串生成字典
+(NSDictionary *)creatDicWithString:(NSString *)result
{
    /* 字符串的格式
     'ID':'Us20130910154600','USERNAME':'ma','ZW':'1','ShopId':'Mjd20131106101823000013','ShopName':'中州大道','CityId':'Mjd20131106101823000007','CityName':'北京','PROJECTID':'Xm20130908','ProjectName':'好声音加多宝凉茶活动';
     */
    NSArray *array = [result componentsSeparatedByString:@","];
    NSMutableDictionary *mDic = [[[NSMutableDictionary alloc]initWithCapacity:3] autorelease];
    for (NSString *str in array) {
        NSArray *subArray = [str componentsSeparatedByString:@":"];
        NSString *keyStr = [subArray objectAtIndex:0];
        NSString *valueStr = [subArray objectAtIndex:1];
        
        [mDic setObject:[valueStr substringWithRange:NSMakeRange(1, valueStr.length-2)] forKey:[keyStr substringWithRange:NSMakeRange(1, keyStr.length-2)]];
    }
    
    return mDic;
}

#pragma mark - 保存图片至沙盒
+(void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//从沙盒读取图片
+(UIImage*)getImageFromFileByName:(NSString*)imageName
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    UIImage *image = [[[UIImage alloc] initWithContentsOfFile:fullPath]autorelease];
    
    return image;
}
//字符串转化成日期
+(NSDate*)dateFromString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    [dateFormatter release];
    return destDate;
}
//比较时间 -1小于  0等于   1大于
+(int)dateCompare:(NSDate*)startDate endDate:(NSDate*)endDate
{
    NSTimeInterval _fitstDate = [startDate timeIntervalSince1970]*1;
    NSTimeInterval _secondDate = [endDate timeIntervalSince1970]*1;
    
    if (_fitstDate - _secondDate > 0) {
        return 1;
    }else if (_fitstDate-_secondDate==0){
        return 0;
    }else{
        return -1;
    }
}

//显示Alert
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

/*
 *  地球坐标和火星坐标转换  start
 */
const double pi = 3.14159265358979324;

//
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
const double a = 6378245.0;
const double ee = 0.00669342162296594323;

//
// World Geodetic System ==> Mars Geodetic System
+ (void)locationTransformWithwgLat:(double) wgLat withwgLon:(double)wgLon whitmgLat:(double*)mgLat whitmgLat:(double*) mgLon
{
    if ([self outOfChina:wgLat withLon: wgLon])
    {
        *mgLat = wgLat;
        *mgLon = wgLon;
        return;
    }
    double dLat = [self transformLat:wgLon - 105.0 withY: wgLat - 35.0];
    double dLon = [self transformLon:wgLon - 105.0 withY: wgLat - 35.0];
    double radLat = wgLat / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    *mgLat = wgLat + dLat;
    *mgLon = wgLon + dLon;
}
    
+(BOOL) outOfChina:(double)lat withLon:(double) lon
{
    if (lon < 72.004 || lon > 137.8347)
        return YES;
    if (lat < 0.8293 || lat > 55.8271)
        return YES;
    return NO;
}
    
+(double) transformLat:(double)x withY:(double) y
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}
    
+(double) transformLon:(double)x withY:(double) y
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}

+(Location)LocationMake:(double)lng withLat:(double) lat
{
    Location loc; loc.lng = lng, loc.lat = lat; return loc;
}
///
///  GCJ-02 坐标转换成 BD-09 坐标
///

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
+(Location) bd_encrypt:(Location) gcLoc
{
    double x = gcLoc.lng, y = gcLoc.lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
//    return LocationMake(z * cos(theta) + 0.0065, z * sin(theta) + 0.006);
    return [XCommon LocationMake:z * cos(theta) + 0.0065 withLat:z * sin(theta) + 0.006];
}

///
///   BD-09 坐标转换成 GCJ-02坐标
///
///
+(Location) bd_decrypt:(Location) bdLoc
{
    double x = bdLoc.lng - 0.0065, y = bdLoc.lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
//    return LocationMake(z * cos(theta), z * sin(theta));
    return [XCommon LocationMake:z * cos(theta) withLat:z * sin(theta)];
}
/*
 *  地球坐标和火星坐标转换 end
 */

// 判断邮箱格式
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 获得图片类型
+ (NSString *)typeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @".jpeg";
        case 0x89:
            return @".png";
        case 0x47:
            return @".gif";
        case 0x49:
        case 0x4D:
            return @".tiff";
    }
    return nil;
}

//程序版本
+ (NSString *)versionStringDisplay
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *envirType = @"";
    NSString *appVersion;
#ifdef KZFT_TEST
    envirType = @"Test";
//    envirType = [NSString stringWithFormat:@"%@ %@",envirType,[Utility hmsOfDate:[NSDate date]]];
    
    appVersion = [NSString stringWithFormat:@"%@ %@",
                  [infoDict objectForKey:@"CFBundleShortVersionString"],envirType];
#else
    appVersion = [NSString stringWithFormat:@"%@",
                  [infoDict objectForKey:@"CFBundleShortVersionString"]];
#endif
    
    return appVersion;
}

//解析经纬度字符串  "40.343434,129.394884"
+ (CLLocationCoordinate2D)location2DByString:(NSString*)locStr
{
    CLLocationCoordinate2D loc2D;
    NSRange range = [locStr rangeOfString:@","];
    int location = range.location;
    int lenght = range.length;
    loc2D.latitude = [[locStr substringToIndex:location-lenght] floatValue];
    loc2D.longitude = [[locStr substringFromIndex:(location + lenght)] floatValue];
    
    return loc2D;
}

//距离转换，返回的是单位是米，分千米和米两种单位显示，小于1000米，则显示米
+ (NSString*)distanceByMeter:(NSString *)meterDis
{
    int dis = [meterDis intValue];
    if (dis<1000) {
        return [NSString stringWithFormat:@"%dm",dis];
    }else if(dis<100000){
        return [NSString stringWithFormat:@"%.1lfkm",dis/1000.0];
    }else{
        return [NSString stringWithFormat:@"%dkm",dis/1000];
    }
}

//强制转换屏幕
+(void)setViewOrientation:(UIInterfaceOrientation )orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    [UIViewController attemptRotationToDeviceOrientation];//这句是关键
}

//计算文件夹下文件的总大小
+(long)fileSizeForDir:(NSString*)path
{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    [fileManager release];
    return size;
}

// 删除图片缓存
+ (BOOL) deleteDirInCache:(NSString *)dirName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirName isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:dirName error:nil];
    }
    
    return isDeleted;
}
@end
