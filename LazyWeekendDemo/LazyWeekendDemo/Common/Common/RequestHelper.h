//
//  RequestHelper.h
//
//  Created by 吴筠秋 on 15/09/01.
//  Copyright © 2015年 吴筠秋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Request_GET @"GET"
#define Request_POST @"POST"

@interface RequestHelper : NSObject

/**
 *  POST 请求
 *
 *  @param urlString 请求路径
 *  @param params    请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)POST:(NSString *)urlString params:(NSDictionary *)params
     success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail;

/**
 *  GET 请求
 *
 *  @param urlString 请求路径
 *  @param params    请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)GET:(NSString *)urlString params:(NSDictionary *)params
     success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail;

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
          success:(void(^)(id data))success fail:(void(^)(id code, id msg))fail;

/**
 * uri 请求短地址
 * parameters 请求参数
 * method "GET" "POST"
 */
+ (NSString *)getRequestUrlWithURI:(NSString *)uri Parameters:(NSDictionary *)parameters RequestMethod:(NSString *)method;

/**
 * 获得完整请求参数数据表
 *
 * uri 请求短地址
 * parameters 请求参数
 * method "GET" "POST"
 */
+ (NSDictionary *)getParamsWithURI:(NSString *)uri Parameters:(NSDictionary *)parameters RequestMethod:(NSString *)method;

+ (NSString *)getFullUrl:(NSString *)uri;

//拼凑出完整地址
+(NSString*)printfFulUrlWith:(NSString*)uri andDic:(NSDictionary*)dic;

/*-----------------------------生成签名值步骤------------------------------------------------
 *-----------------------------------------------------------------------------------------
 *生成签名值
 */
+ (NSString *)getAppUsignWithParamters:(NSDictionary *)parameters;

@end
