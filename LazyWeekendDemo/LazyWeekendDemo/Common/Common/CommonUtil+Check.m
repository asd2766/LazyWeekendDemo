//
//  CommonUtil+Check.m
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/10/31.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "CommonUtil+Check.h"

@implementation CommonUtil (Check)


/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES 格式正确 NO 格式错误
 */
+(BOOL)checkEmailForm:(NSString*)email{
    
    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

/**
 *  checkPhonenum
 *
 *  @param phone 手机号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkPhonenum:(NSString *)phone {
    if ([phone hasPrefix:@"+86"]) {
        phone = [phone substringFromIndex:3];
    }
    //手机号以1开头，11位数字
    NSString *phoneRegex = @"^[1][3-8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

/**
 *  判断电话号码格式
 *
 *  @param cellPhone 电话号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkCellPhone:(NSString *)cellPhone{
    //手机号以1开头，11位数字
    NSString *phoneRegex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7,8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:cellPhone];
}

/**
 *  判断是否是数字,最多两个小数点
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNum:(NSString *)num{
    //数字
    NSString *regex = @"^[0-9]\\d*|^[1-9]\\d*\\.\\d{0,2}|0\\.\\d{0,2}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:num];
}

/**
 *  判断是否只是数字
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkOnlyNum:(NSString *)num{
    //数字
    NSString *regex = @"^(0|[1-9][0-9]*)$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:num];
}

/**
 *  判断是否是数字和字母
 *
 *  @param string 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNumAndLetter:(NSString *)string{
    
    //数字 和字母
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%lu}$",(unsigned long)string.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:string];
}


/**
 *  不能输入特殊字符，可以输入字母，中文，[]【】(){}《》.,?_><!:;''""，、。？；/ & ：“”‘’！
 *
 *  @param content 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkContent:(NSString *)content{
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9.\u4e00-\u9fa5\\[\\]【】(){}《》.,?_><!:;''""，@、/。\\+？；&：\\-\\－“”‘’！\\w\\s%@]{%lu}$",  @"\\%", (unsigned long)content.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:content];
}

/**
 *  只能输入中文 字母 数字 空格
 *
 *  @param content 内容
 *
 *  @return YES:格式正确  NO:格式错误
 */
+ (BOOL)checkString:(NSString *)content{
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9\u4e00-\u9fa5()（）\\s]{%lu}$", (unsigned long)content.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:content];
}


/**
 *  判断是否含有表情
 *
 *  @param string 传入的字符串
 *
 *  @return YES:含有字符串 NO:不含有字符串
 */
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


/**
 *  校验密码复杂度
 *
 *  @param pwd 密码
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkPwd:(NSString *)pwd{
    
    //6-20位，英文，数字或符号
    NSString *regex = @"((?=.*\\d)(?=.*\\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))^.{6,20}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:pwd];
    
}

/**
 *  校验款号复杂度
 *
 *  @param number 款号
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkNumber:(NSString *)number{
    
    //是否包含中文
    //    NSString *regex = @"[\u4e00-\u9fa5]$";
    //    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //    if ([test evaluateWithObject:number]) {
    //        //包含中文
    //        return NO;
    //    }
    
    //字母、数字、下划线和短横
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9_-]{%lu}$", (unsigned long)number.length];
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [test evaluateWithObject:number];
    
}

/**
 *  校验email复杂度
 *
 *  @param email 邮件
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkEmail:(NSString *)email{
    NSString *regex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:email];
}
@end
