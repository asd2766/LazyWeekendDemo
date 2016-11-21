//
//  CommonUtil+Check.h
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/10/31.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "CommonUtil.h"

@interface CommonUtil (Check)


/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES 格式正确 NO 格式错误
 */
+(BOOL)checkEmailForm:(NSString*)email;


/**
 *  checkPhonenum
 *
 *  @param phone 手机号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkPhonenum:(NSString *)phone;


/**
 *  判断电话号码格式
 *
 *  @param cellPhone 电话号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkCellPhone:(NSString *)cellPhone;

/**
 *  判断是否是数字(小数点后两位)
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNum:(NSString *)num;

/**
 *  判断是否只是数字
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkOnlyNum:(NSString *)num;


/**
 *  判断是否是数字和字母
 *
 *  @param string 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNumAndLetter:(NSString *)string;


/**
 *  不能输入特殊字符，可以输入字母，中文，[]【】(){}《》.,?><!:;''""，、。？；：“”‘’！
 *
 *  @param content 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkContent:(NSString *)content;


/**
 *  只能输入中文 字母 数字 空格
 *
 *  @param content 内容
 *
 *  @return YES:格式正确  NO:格式错误
 */
+ (BOOL)checkString:(NSString *)content;


/**
 *  判断是否含有表情
 *
 *  @param string 内容
 *
 *  @return YES:含有表情 NO:不含有表情
 */
+(BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  校验密码复杂度
 *
 *  @param pwd 密码
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkPwd:(NSString *)pwd;

/**
 *  校验款号复杂度
 *
 *  @param number 款号
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkNumber:(NSString *)number;

/**
 *  校验email复杂度
 *
 *  @param email 邮件
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkEmail:(NSString *)email;


@end
