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
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:mUrl parameters:params error:nil];
    request.timeoutInterval = 20;
    [request setAllHTTPHeaderFields:[[YLGlobalUserInfo getGlobalUserInfo] getLocalHeaderInfo]];
    
    WEAKSELF
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        STRONGSELF
        [strongSelf parseResponseData:response id:responseObject error:error url:mUrl successHander:success failHander:fail alert:alert];
    }];
    [dataTask resume];
    return dataTask;
}


- (NSURLSessionDataTask *)GetWithUrl:(NSString *)url Params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *, NSInteger, id, NSString *))fail
{
    return [self GetWithUrl:url Params:params successHander:success failHander:fail alert:YES];
}

- (NSURLSessionDataTask *)GetWithUrl:(NSString *)url Params:(id)params successHander:(void (^)(NSDictionary *))success failHander:(void (^)(NSError *er , NSInteger httpStatus, id response, NSString *msg))fail alert:(BOOL)alert
{
    NSString *Murl = url;
    if (![Murl hasPrefix:@"http"]) {
        Murl = [NSString stringWithFormat:@"%@%@",API_ServiceUrlDomain,url];
    }
    
//    NSString *s = [NSString stringWithFormat:@"pn=%@&vc=%@&pltm=%@&chn=%@&svc=%@&did=%@",[AppData getAppBundleID],[AppData getAppBuildNumber],@"ios", @"ios",[AppData getSystemeVersion], [[AppData sharedAppData] getAppUUID]];
//    NSString *encrypted = [self aesEncryptedWithData:s];
//    Murl = [NSString stringWithFormat:@"%@", Murl];
    NSLog(@"url  is  %@", Murl);
    NSLog(@"params  is  %@", params);
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:Murl parameters:params error:nil];
    [request setTimeoutInterval:20]; //设置过期时间
    [request setAllHTTPHeaderFields:[[YLGlobalUserInfo getGlobalUserInfo] getLocalHeaderInfo]];
    
    WEAKSELF
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        STRONGSELF
        [strongSelf parseResponseData:response id:responseObject error:error url:Murl successHander:success failHander:fail alert:alert];
    }];
    [dataTask resume];
    return dataTask;
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
                    if ([data[@"code"] integerValue] == 200) {
                        success(data);
                    }else{
                        NSError *er = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:[data[@"code"] intValue] userInfo:nil];
                        fail(er,500,responseObject,[self getNetErrorMsg:[data[@"code"] intValue]]);
                    }
                }else{
                    fail([[NSError alloc] init], 500, responseObject, @"网络异常");
                }
            }else{
                fail([[NSError alloc] init], 500, responseObject, @"网络异常");
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

//- (NSString *)aesEncryptedWithData:(NSString *)str
//{
//    //    CCCryptorStatus status = kCCSuccess;
//    //    NSData *result = [[@"pltm=android&pn=com.brahms.wallet&vc=1&svc=7.0&chn=ofw" dataUsingEncoding:NSUTF8StringEncoding] dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:Net_AES_Key options:(kCCOptionPKCS7Padding|kCCOptionECBMode) error:&status];
//    //    if (status != kCCSuccess) {
//    //        NSLog(@"AES 加密失败....");
//    //        return @"";
//    //    }
//    //NSString *resultStr = [NSString hexWithData:result];
//    NSString *resultStr = [self encyptPKCS5:str WithKey:Net_AES_Key];
//    if (!resultStr) {
//        NSLog(@"AES hexWithData失败....");
//        return @"";
//    }
//    return resultStr;
//}

//- (NSString*)encyptPKCS5:(NSString*)plainText WithKey:(NSString*)key{
//
//    //把string转NSData
//
//    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//
//    //length
//
//    size_t plainTextBufferSize = [data length];
//
//    const void *vplainText = (const void*)[data bytes];
//
//    uint8_t*bufferPtr =NULL;
//
//    size_t bufferPtrSize =0;
//
//    size_t movedBytes =0;
//
//    bufferPtrSize = (plainTextBufferSize +kCCBlockSizeAES128) & ~(kCCBlockSizeAES128-1);
//
//    bufferPtr =malloc( bufferPtrSize *sizeof(uint8_t));
//
//    memset((void*)bufferPtr,0x0, bufferPtrSize);
//
//    const void*vkey = (const void*) [key UTF8String];
//
//    //配置CCCrypt
//
//    CCCryptorStatus ccStatus =CCCrypt(kCCEncrypt,
//
//                                      kCCAlgorithmAES128,//3DES
//
//                                      kCCOptionECBMode|kCCOptionPKCS7Padding,//设置模式
//
//                                      vkey,//key
//
//                                      kCCKeySizeAES128,
//
//                                      nil,//偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
//
//                                      vplainText,
//
//                                      plainTextBufferSize,
//
//                                      (void*)bufferPtr,
//
//                                      bufferPtrSize,
//
//                                      &movedBytes);
//
//    if(ccStatus ==kCCSuccess) {
//
//        NSData*myData = [NSData dataWithBytes:(const char*)bufferPtr length:(NSUInteger)movedBytes];
//
//        NSUInteger len = [myData length];
//
//        char*chars = (char*)[myData bytes];
//
//        NSMutableString*hexString = [[NSMutableString alloc]init];
//
//        for(NSUInteger i =0; i < len; i++ )
//
//            [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
//
//        //16进制
//
//        return hexString;
//
//    }
//
//    free(bufferPtr);
//
//    return nil;
//
//}



@end
