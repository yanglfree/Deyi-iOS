//
//  YLNetwork.m
//  deyi
//
//  Created by Liang on 2018/8/1.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLNetwork.h"

static AFHTTPSessionManager *manager = nil;

@implementation YLNetwork

+ (instancetype)sharedNetwork
{
    static YLNetwork *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[YLNetwork alloc] init];
        manager = [AFHTTPSessionManager manager];
    });
    return network;
}

- (NSURLSessionDataTask *)PostWithUrl:(NSString *)url params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *, NSInteger, id, NSString *))fail
{
    return [self PostWithUrl:url params:params successHander:success failHander:fail alert:YES];
}

- (NSURLSessionDataTask *)PostWithUrl:(NSString *)url params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *, NSInteger, id, NSString *))fail alert:(BOOL)alert
{
    NSString *mUrl = [NSString stringWithFormat:@"%@%@",API_ServiceUrlDomain,url];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:mUrl parameters:params error:nil];
    request.timeoutInterval = 20;
    [request setAllHTTPHeaderFields:[[YLGlobalUserInfo getGlobalUserInfo] getLocalHeaderInfo]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self parseResponseData:response id:responseObject error:error url:mUrl successHander:success failHander:fail alert:alert];
    }];
    [dataTask resume];
    return dataTask;
    
}


- (NSURLSessionDataTask *)GetWithUrl:(NSString *)url Params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *, NSInteger, id, NSString *))fail
{
    return nil;
}

- (void)parseResponseData:(NSURLResponse *)response id:(id)responseObject error:(NSError *)error url:(NSString *)url successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *er , NSInteger httpStatus, id response, NSString *msg))fail alert:(BOOL)alert
{
    NSLog(@"url: %@ responseObject %@",url, responseObject);
    if (error) {
        NSInteger httpS = 0;
        BOOL tokenInvalid = NO;
        if ([response isMemberOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *rsp = (NSHTTPURLResponse *)response;
            httpS = rsp.statusCode;
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSError *er = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:[data[@"code"] intValue] userInfo:nil];
            if ([data[@"code"] integerValue] == 1003) {
                
            }else{
                fail(er,httpS,responseObject,[self getNetErrorMsg:[data[@"code"] intValue]]);
            }
        }else{
            fail(error,httpS,responseObject,error.userInfo[@"NSLocalizedDescription"]);;
        }
        
        if (alert && !tokenInvalid) {
        }
    }else{
        if (success) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *data = (NSDictionary *)responseObject;
                if (!data[@"code"] || [data[@"code"] intValue] != 0) {
                    if ([data[@"code"] integerValue] == 1003) {
                        
                    }else{
                        NSError *er = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:[data[@"code"] intValue] userInfo:nil];
                        fail(er,200,responseObject,[self getNetErrorMsg:[data[@"code"] intValue]]);
                    }
                }else{
                    success(data);
                }
            }else{
                fail([[NSError alloc] init], 200, responseObject, @"网络异常");
            }
        }
    }
}

- (NSString *)getNetErrorMsg:(int)code
{
    NSString *localStr = [NSString stringWithFormat:@"net_error_%d", code];
    NSString *msg = NSLocalizedString(localStr, nil);
    if (msg) {
        return msg;
    }
    return @"网络异常";
}


@end
