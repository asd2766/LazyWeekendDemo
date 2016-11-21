//
//  CommonUtil+Calculate.m
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/10/31.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "CommonUtil+Calculate.h"

@implementation CommonUtil (Calculate)


/****************** 关于数字加减乘除方法 <S> ******************/
/**
 *  加法
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByAdding:addNum withBehavior:roundUp];
}

/**
 *  加法 （四舍五入）
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd2:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum{
    /*
     保留两位小数
     NSRoundBankers,    // 四舍五入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByAdding:addNum withBehavior:roundUp];
}


/**
 *  减法
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberBySubtracting:subtractNum withBehavior:roundUp];
}

/**
 *  减法 （四舍五入）
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract2:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum{
    /*
     保留两位小数
     NSRoundBankers,    //四舍五入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberBySubtracting:subtractNum withBehavior:roundUp];
}

/**
 *  乘法
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumMultiply:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
}

/**
 *  乘法 (四舍五入)
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数,四舍五入
 */
+ (NSDecimalNumber *)decimalNumMultiply2:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum{
    /*
     保留两位小数
     NSRoundBankers,    //四舍五入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
}


/**
 *   处理获取的字符串 保留小数点后两位
 *
 *    @brief    截取指定小数位的值
 *
 *    @param     price     目标数据
 *    @param     position     有效小数位
 *
 *    @return    截取后数据
 */
+ (NSString *)notRounding:(NSString*)price afterPoint:(NSInteger)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain                                               scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSString * finaPrice = [NSString stringWithFormat:@"%@",roundedOunces];
    
    if ([finaPrice rangeOfString:@"."].length!=0) {
        
        NSRange range = [finaPrice rangeOfString:@"."];
        if ([finaPrice substringFromIndex:range.location].length==2) {
            return [NSString stringWithFormat:@"%@0",finaPrice];
        }
        return finaPrice;
    }else{
        
        NSString * point = @"";
        for (int i =0; i<position; i++) {
            if ([self isEmpty:point]) {
                point = @".0";
            }else{
                point = [NSString stringWithFormat:@"%@%@",point,@"0"];
            }
        }
        return [NSString stringWithFormat:@"%@%@",finaPrice,point];
    }
    
}

@end
