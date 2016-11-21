//
//  RequestHelper.m
//  wedding
//
//  Created by duanjycc on 14/11/14.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import "RequestHelper.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "base64.h"
#import "Consts.h"
#import "CommonUtil.h"
#import "UserInfo.h"
#import "AFNetworking.h"

@implementation RequestHelper

#pragma mark - 请求
/**
 *  POST 请求
 *
 *  @param urlString 请求路径
 *  @param params    请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)POST:(NSString *)urlString params:(NSDictionary *)params
     success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail {
    
    NSDictionary *parameters = [self getParamsWithURI:urlString Parameters:params RequestMethod:Request_POST];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:[self getFullUrl:urlString] parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        if ([RESPONSE_OK isEqualToString:result[@"code"]]) {
            //获取数据成功
            success(responseObject[@"data"]);
        } else if ([RESPONES_NOLOGIN isEqualToString:result[@"code"]]) {
            // 登录失效，需要重新登录
            NSString *msg = [CommonUtil isEmpty:responseObject[@"result"][@"message"]]?@"请重新登录":responseObject[@"result"][@"message"];
            fail(result[@"code"], msg);
            [[CommonUtil currentUtil] reloadLogin:YES];//重新登录
        } else {
            NSString *msg = @"数据有误，请联系管理员";
            fail(result[@"code"], msg);
            
            // 提交错误信息到数据库中
            NSString *errMsg = [NSString stringWithFormat:@"%@ 返回错误: %@", urlString, [result[@"message"] description]];
            NSLog(@"error: %@", errMsg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        fail(@"", ERR_NETWORK);
    }];
}

/**
 *  GET 请求
 *
 *  @param urlString 请求路径
 *  @param params    请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)GET:(NSString *)urlString params:(NSDictionary *)params
    success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail {
    
    NSDictionary *parameters = [self getParamsWithURI:urlString Parameters:params RequestMethod:Request_GET];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:[self getFullUrl:urlString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        if ([RESPONSE_OK isEqualToString:result[@"code"]]) {
            //获取数据成功
            success(responseObject[@"data"]);
        } else if ([RESPONES_NOLOGIN isEqualToString:result[@"code"]]) {
            // 登录失效，需要重新登录
            NSString *msg = [CommonUtil isEmpty:responseObject[@"result"][@"message"]]?@"请重新登录":responseObject[@"result"][@"message"];
            fail(result[@"code"], msg);
            [[CommonUtil currentUtil] reloadLogin:YES];//重新登录
        } else{
            NSString *msg = @"数据有误，请联系管理员";
            fail(result[@"code"], msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        fail(@"", ERR_NETWORK);
    }];
}

/**
 *  上传图片
 *
 *  @param urlString 请求路径
 *  @param params    请求参数
 *  @param image     图片
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)uploadImgRequest:(NSString *)urlString params:(NSDictionary *)params image:(UIImage *)image
     success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail {
    
    NSDictionary *parameters = [self getParamsWithURI:urlString Parameters:params RequestMethod:Request_POST];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:[RequestHelper getFullUrl:urlString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.7) name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = responseObject[@"result"];
        if ([[result[@"code"] description] isEqualToString:RESPONSE_OK]) {
            // 获取数据成功
            success(responseObject[@"data"]);
        } else if ([RESPONES_NOLOGIN isEqualToString:result[@"code"]]) {
            // 登录失效，需要重新登录
            NSString *msg = [CommonUtil isEmpty:responseObject[@"result"][@"message"]]?@"请重新登录":responseObject[@"result"][@"message"];
            fail(result[@"code"], msg);
            [[CommonUtil currentUtil] reloadLogin:YES];//重新登录
        } else {
            NSString *msg = @"数据有误，请联系管理员";
            fail(result[@"code"], msg);
            
            // 提交错误信息到数据库中
            NSString *errMsg = [NSString stringWithFormat:@"%@ 返回错误: %@", urlString, [result[@"message"] description]];
            NSLog(@"error: %@", errMsg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        fail(@"", ERR_NETWORK);
    }];
}

#pragma mark - url相关方法
+ (NSString *)getFullUrl:(NSString *)uri {
    NSString* url= [NSString stringWithFormat:@"%@%@", REQUEST_HOST, uri];
    return url;
}

///**
// * 获得完整请求参数数据表
// *
// * uri 请求短地址
// * parameters 请求参数
// * method "GET" "POST"
// */
//+ (NSDictionary *)getParamsWithURI:(NSString *)uri Parameters:(NSDictionary *)parameters RequestMethod:(NSString *)method {
//    NSMutableDictionary *reqParams = [NSMutableDictionary dictionary];
//    
//    UserInfo *info = [];
//    NSString *custId = [CommonUtil isEmpty:info.custId]?@"":info.custId;
//    [reqParams setObject:custId forKey:@"authId"];
//    
//    NSString *authTime = info.authTime;
//    
//    [reqParams setObject:authTime forKey:@"authTime"];
//    [reqParams setObject:[NSString stringWithFormat:@"%u",arc4random()%10000] forKey:@"timeid"];//添加的随机数，为了混淆视听
//    
//    if (parameters) {
//        [reqParams addEntriesFromDictionary:parameters];
//    }
//    
//    [reqParams setObject:[RequestHelper getAppUsignWithParamters:reqParams] forKey:@"sign"];
//    
//    return reqParams;
//}

/**
 * uri 请求短地址
 * parameters 请求参数
 * method "GET" "POST"
 */
+ (NSString *)getRequestUrlWithURI:(NSString *)uri Parameters:(NSMutableDictionary *)parameters RequestMethod:(NSString *)method {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    } else {
        if (![parameters isKindOfClass:[NSMutableDictionary class]]) {
            parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        }
    }
    
    [parameters addEntriesFromDictionary:[RequestHelper getDefaultParameters]];

    if ([method isEqualToString:@"POST"]) {
        return [NSString stringWithFormat:@"%@%@",REQUEST_HOST, uri];
    } else {
        NSMutableString *sortString = [NSMutableString string];
        NSArray *allkeys = parameters.allKeys;
        for (int i=0; i<[allkeys count]; i++) {
            NSString *key = [allkeys objectAtIndex:i];
            NSString *value = [parameters objectForKey:key];

            [sortString appendFormat:@"%@=%@",key,[RequestHelper encodeURL:value]];
            if (i < [allkeys count]-1) {
                [sortString appendString:@"&"];
            }
        }
        if ([uri rangeOfString:@"?"].location == NSNotFound)
        {
            return [NSString stringWithFormat:@"%@%@?%@",REQUEST_HOST, uri, sortString];
        }else{
            return [NSString stringWithFormat:@"%@%@&%@",REQUEST_HOST, uri, sortString];
        }
    }
}

//拼凑出完整地址
+(NSString*)printfFulUrlWith:(NSString*)uri andDic:(NSDictionary*)dic{

//    NSString * baseUri = [NSString stringWithFormat:@"%@%@",REQUEST_HOST,uri];
    NSMutableString * muUri = [NSMutableString stringWithString:uri];
    NSArray * keyArr = dic.allKeys;
    for (int i =0; i<keyArr.count; i++) {
        if (i==0) {
            [muUri appendString:[NSString stringWithFormat:@"?%@=%@",keyArr[i],dic[keyArr[i]]]];
        }else{
            [muUri appendString:[NSString stringWithFormat:@"&%@=%@",keyArr[i],dic[keyArr[i]]]];
        
        }
    }
    
    return muUri;
}

#pragma mark - private
/*
 *每个请求的默认请求参数
 *
 *  params:
 *
 *  app_id:协定的app id
 *  client_timestamp:当前时间戳
 *  client_version:app当前版本号
 *  client_guid:每个客户端申请的唯一ID(客户端静默注册)
 *  access_token:用户访问凭证token(用户登录后所有请求都需要带此参数）
 *
 */
+ (NSDictionary *)getDefaultParameters{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [params setObject:APP_ID forKey:@"app_id"];
//    
//    NSString *timeInterval = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
//    [params setObject:timeInterval forKey:@"client_timestamp"];
//    
//    [params setObject:APP_VERSION forKey:@"client_version"];
//    
//    NSString *client_id = [CommonUtil getObjectFromUD:@"client_id"];
//    if (![CommonUtil isEmpty:client_id]) {
//        [params setObject:client_id forKey:@"client_guid"];
//    }
    //用户ID
//    NSString *userid = [[CommonUtil currentUtil] getLoginUserid];
//    if (![CommonUtil isEmpty:userid]) {
//        [params setObject:userid forKey:@"userid"];
//    }
    
    return params;
}

/*-----------------------------生成签名值步骤------------------------------------------------
 *-----------------------------------------------------------------------------------------
 *生成签名值
 */

+ (NSString *)getAppUsignWithParamters:(NSDictionary *)parameters{

    
    NSArray *keys = [parameters allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];//不区分大小写比较
    }];
    
    
    NSString *url = @"";
    
    for (NSString *key in sortedArray) {
        
        if ([CommonUtil isEmpty:url]) {
            if ([[parameters objectForKey:key] isKindOfClass:[NSArray class]]) {
                NSArray * keyArr = [parameters objectForKey:key];
                NSMutableString * mutStr = [NSMutableString string];
                
                for (NSString * str in keyArr) {
                    if ([CommonUtil isEmpty:mutStr]) {
                        mutStr = [NSMutableString stringWithFormat:@"%@",str];
                    }else{
                        mutStr = [NSMutableString stringWithFormat:@"%@,%@",mutStr,str];
                    }
                    
                }
                url = [NSString stringWithFormat:@"%@[]=%@", key, mutStr];
            }else{
                url = [NSString stringWithFormat:@"%@=%@", key, [parameters objectForKey:key]];
            }
        }else{
            if ([[parameters objectForKey:key] isKindOfClass:[NSArray class]]) {
                NSArray * keyArr = [parameters objectForKey:key];
                NSMutableString * mutStr = [NSMutableString string];
                
                for (NSString * str in keyArr) {
                    if ([CommonUtil isEmpty:mutStr]) {
                        mutStr = [NSMutableString stringWithFormat:@"%@",str];
                    }else{
                        mutStr = [NSMutableString stringWithFormat:@"%@,%@",mutStr,str];
                    }
                    
                }
                url = [NSString stringWithFormat:@"%@&%@[]=%@", url, key, mutStr];
            }else{
                url = [NSString stringWithFormat:@"%@&%@=%@", url, key, [parameters objectForKey:key]];
            }
        }
        
    }
    
    if ([CommonUtil isEmpty:url]) {
        url = @"cd6161d78d147035530741d87d1616dc";
    }else{
        url = [NSString stringWithFormat:@"%@&cd6161d78d147035530741d87d1616dc", url];
    }
    
    NSString *sign = [CommonUtil md5:url];
    
    return sign;
    
//
//    
//    NSArray *sorts = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2) {
//        return [key1 caseInsensitiveCompare:key2];
//    }];
//    NSMutableString *sortString = [NSMutableString string];
//    for (int i=0; i<[sorts count]; i++) {
//        NSString *key = [sorts objectAtIndex:i];
//        NSString *value = [parameters objectForKey:key];
//        [sortString appendFormat:@"%@=%@",key,value];
//        if (i < [sorts count]-1) {
//            [sortString appendString:@"&"];
//        }
//    }
//    NSString *paras = [RequestHelper encodeURL:sortString];
//    NSString *value = [NSString stringWithFormat:@"%@&%@&%@",requestMethod, uri, paras];
//    NSString *key = [NSString stringWithFormat:@"%@&",APP_KEY];
//    NSString *usign = [RequestHelper hmacsha1:value key:key];

}

/*
 *不参与签名参数：
 *      a.	长度大于3 并且r[a-z]_开头或者_s[a-z]结尾 ；
 *      b.	app_usign
 *  （   再此将改字段过滤掉）
 */
+ (BOOL)deleteKey:(NSString *)key{
    if ([key length] <= 3) {
        return NO;
    }
    if ([key isEqualToString:@"upload"]) {
        return YES;
    }
    NSString *regex = @"r[a-z]_[a-zA-Z0-9_]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isDelete = [predicate evaluateWithObject:key];
    if (!isDelete) {
        regex = @"[a-zA-Z0-9_]+_s[a-z]";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        isDelete = [predicate evaluateWithObject:key];
    }
    return isDelete;
}

/*
 *使用HMAC-SHA1加密算法，将构造源串以密钥进行加密
 */
//+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)key{
//    NSData *secretData = [key dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
//    unsigned char result[20];
//    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
//    char base64Result[32];
//    size_t theResultLength = 32;
//    Base64EncodeData(result, 20, base64Result, &theResultLength, YES);
//    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
//    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
//    return base64EncodedResult;
//}

/*
 *encodeURL
 */
+ (NSString*)encodeURL:(NSString *)string{
    if (![string isKindOfClass:[NSString class]]) {
        return string;
    }
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))) ;
    if (newString) {
        return newString;
    }
    return @"";
}

@end
