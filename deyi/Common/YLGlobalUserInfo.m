//
//  YLGlobalUserInfo.m
//  deyi
//
//  Created by Liang on 2018/8/1.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLGlobalUserInfo.h"

@implementation YLGlobalUserInfo

@synthesize token = _token;

+ (instancetype)getGlobalUserInfo
{
    static YLGlobalUserInfo *global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[YLGlobalUserInfo alloc] init];
    });
    return global;
}

- (void)setToken:(NSString *)token
{
    _token = [token copy];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USER_LOCAL_TOKEN];
}

- (NSString *)getToken
{
    if (_token) {
        return _token;
    }else{
        return [self getLocalToken];
    }
}

- (NSDictionary *)getLocalHeaderInfo
{
    NSString *timeStr = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSinceNow];
    NSString *deviceId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    return @{@"TYPE":@"ios",
             @"Content-Type":@"application/json",
                                     @"DEVICEID":deviceId,
                                     @"USERID":@"",
                                     @"Accept-Language":@"zh-Hans-CN;q=1, en-CN;q=0.9, ja-CN;q=0.8, ar-CN;q=0.7, pt-BR;q=0.6",
                                     @"User-Agent":@"DeyiLife/6.3.9 (iPhone; iOS 11.4.1; Scale/2.00)",
                                     @"AREAID":@"258",
                                     @"Connection":@"keep-alive",
                                     @"VERSION":YLAppVersion,
                                     @"TIMESTAMP": timeStr,
                                     @"Accept-Encoding":@"gzip, deflate",
             };
}

- (NSString *)getLocalToken
{
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOCAL_TOKEN];
    return _token;
}

@end
