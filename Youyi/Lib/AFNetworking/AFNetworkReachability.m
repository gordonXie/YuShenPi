//
//  AFNetworkReachability.m
//  jiajia
//
//  Created by xieguocheng on 14-7-16.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "AFNetworkReachability.h"
#import "AFHTTPClient.h"

@implementation AFNetworkReachability
+(BOOL)checkNetworkConnectivity
{
    // 1. AFNetwork 是根据是否能够连接到baseUrl来判断网络连接状态的
    // 提示：最好使用门户网站来判断网络连接状态。
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    BOOL __block isFinishBlock = NO;
    BOOL __block isConnect = YES;
    [client setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 之所以区分无线和3G主要是为了替用户省钱，省流量
        // 如果应用程序占流量很大，一定要提示用户，或者提供专门的设置，仅在无线网络时使用！
        isFinishBlock = YES;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isConnect = NO;
                NSLog(@"未连接");
                break;
            case AFNetworkReachabilityStatusUnknown:
                isFinishBlock = NO;
                NSLog(@"未知错误");
                break;
        }
    }];
    
    while(isFinishBlock == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    
    return isConnect;
}
@end
