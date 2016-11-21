//
//  CommonUtil+Calculate.h
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/10/31.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "CommonUtil.h"

@interface CommonUtil (Calculate)


/****************** 关于数字加减乘除方法 <S> ******************/
/**
 *  加法
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum;

/**
 *  加法 （四舍五入）
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd2:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum;

/**
 *  减法
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum;

/**
 *  减法 （四舍五入）
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract2:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum;

/**
 *  乘法
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumMultiply:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum;

/**
 *  乘法,四舍五入
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数,四舍五入
 */
+ (NSDecimalNumber *)decimalNumMultiply2:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum;

/**
 *  处理获取的价格字符串
 *
 *  @param price    价格
 *  @param position 小数点几位
 *
 *  @return 处理后的字符串
 */

+ (NSString *)notRounding:(NSString*)price afterPoint:(NSInteger)position;

@end
