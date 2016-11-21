//
//  Consts.h
//  Zhaoxie
//
//  Created by HapN on 14-10-24.
//  Copyright (c) 2014年 HapN. All rights reserved.
//

#ifndef Reqeust_demo_Consts_h
#define Reqeust_demo_Consts_h

#define RGB(r,g,b)                      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]
#define RGBA(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define _screenWidth                    [UIScreen mainScreen].bounds.size.width
#define _screenHeight                   [UIScreen mainScreen].bounds.size.height
#define _screenWidthRatio               [UIScreen mainScreen].bounds.size.width/320

#define IOS7                            [[[UIDevice currentDevice] systemVersion] floatValue]>=7
// 等于
#define SYSTEM_VERSION_EQUAL_TO(v)      ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
// 大于
#define SYSTEM_VERSION_GREATER_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
// 小于
#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define iPad                            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IOSVERSION                      [[UIDevice currentDevice] systemVersion]

#define TOAST_TAG                       9999       //toast的bag值

#define DEFAULT_RED                     RGB(204, 0, 0)
#define DEFAULT_LINE_COLOR              RGB(230, 230 ,230)
#define DEFAULT_BLACK                   RGB(67, 67, 67)
#define DEFAULT_GREY_999                RGB(153, 153, 153)
#define DEFAULT_BG_COLOR                RGB(245, 245 ,245)
#define DEFAULT_GREY_666                RGB(102, 102, 102)

//分页
#define PAGESIZE                        @"10"   //一页数量

#define SSID_CMCC                       @"CMCC"
#define SSID_CMCC_EDU                   @"CMCC-EDU"


/**********************  keys ****************************/



/**********************  其他 ****************************/

//定义 --> 测试环境,未定义 --> 正式环境
#define DEBUGMODEL

#ifdef DEBUGMODEL
/**************************** 测试环境  *************************************/
#define IS_DEBUG                           YES

#define REQUEST_HOST                    @""

//zhaoxie.net 以下两个host都需要

#define IMAGE_HOST                      @""
#define IMAGE_HOST_HTTP                 @""

#else  //正式环境
/**************************** 正式环境  *************************************/
#define IS_DEBUG                        NO
#define REQUEST_HOST                    @""

//zhaoxie.net 以下两个host都需要
#define IMAGE_HOST                      @""
#define IMAGE_HOST_HTTP                 @""

#endif

/**************************** 其他参数 *************************************/

#define INDEX_IMAGE_HOST                INDEX_IMAGE_HOST_2

#define APP_VERSION                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ERR_NETWORK                     @"当前网络不稳定，请重试！"
#define RESPONSE_INSTABILITY            @"服务器请求出错,请重试"
#define NO_NETWORK                      @"没有连接网络"
#define RESPONSE_OK                     @"0000"
#define RESPONSE_ERR                    @"9999"
#define RESPONES_NOLOGIN                @"10000"

/**********************  CODE--MSG ****************************/

#endif
