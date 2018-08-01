//
//  YLGlobalUserInfo.h
//  deyi
//
//  Created by Liang on 2018/8/1.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLGlobalUserInfo : NSObject

@property(nonatomic, copy, getter=getToken) NSString *token;
@property(nonatomic, assign) int uid;

+ (instancetype)getGlobalUserInfo;

- (NSString *)getLocalToken;

- (NSDictionary *)getLocalHeaderInfo;

@end
