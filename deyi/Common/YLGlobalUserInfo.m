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
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@", @(self.uid)], @"X-AUTH-USER", self.token, @"X-AUTH-TOKEN", nil];
    return dict;
}

- (NSString *)getLocalToken
{
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOCAL_TOKEN];
    return _token;
}

@end
