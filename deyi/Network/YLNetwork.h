//
//  YLNetwork.h
//  deyi
//
//  Created by Liang on 2018/8/1.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLNetwork : NSObject

+ (instancetype)sharedNetwork;

- (NSURLSessionDataTask *)PostWithUrl:(NSString *)url params:(id)params successHander:(void(^)(NSDictionary *response))success failHander:(void(^)(NSError *error, NSInteger httpStatus, id response, NSString *msg))fail;

- (NSURLSessionDataTask *)PostWithUrl:(NSString *)url params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *, NSInteger, id, NSString *))fail alert:(BOOL)alert;


- (NSURLSessionDataTask*)GetWithUrl:(NSString *)url Params:(id)params successHander:(void (^)(NSDictionary *dict))success failHander:(void (^)(NSError *error, NSInteger httpStatus, id response, NSString *msg))fail;

@end
