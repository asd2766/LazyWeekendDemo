//
//  CommonUtil.m
//  wedding
//
//  Created by duanjycc on 14/11/14.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import "CommonUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UIImageView+WebCache.h"
#import "Consts.h"
#import "CommonUtil+Date.h"
#import "UIViewController+Toast.h"
//#import "UserInfo.h"

static CommonUtil *defaultUtil = nil;

@interface CommonUtil() {
    AppDelegate *appDelegate;
}


@end

@implementation CommonUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return self;
}

+ (instancetype)currentUtil
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultUtil = [[CommonUtil alloc] init];
    });
    
    return defaultUtil;
}

+ (NSString *)stringForID:(id)objectid {
    if ([CommonUtil isEmpty:objectid]) {
        return @"";
    }
    
    if ([objectid isKindOfClass:[NSString class]]) {
        return objectid;
    }
    
    if ([objectid isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:objectid];
    } else {
        return [NSString stringWithFormat:@"%@", objectid];
    }
}

// 判断空字符串
+ (BOOL)isEmpty:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string description] isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  去除左右空格
 *
 *  @param str 需要去除左右空格的字符串
 *
 *  @return 去除左右空格之后的字符串
 */
+ (NSString *)trimStr:(NSString *)str{
    if ([self isEmpty:str]){
        return str;
    }
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return str;
}

/**
 *  判断数组是否为空
 *
 *  @param array 判断的数组
 *
 *  @return YES：为空， NO：不为空
 */
+ (BOOL)arrayIsEmpty:(NSArray *)array{
    
    if (array == nil) {
        return YES;
    }
    
    if (array == NULL){
        return YES;
    }
    
    if ([array isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
        return NO;
    }
    
    if ([array isKindOfClass:[NSArray class]] && array.count == 0) {
        return YES;
    }

    
    return YES;
    
}

/**
 *  判断是否为是nil，null
 *
 *  @param obj 判断的对象
 *
 *  @return YES：是nil，null， NO：不是nil，null类型
 */
+ (BOOL)isNullEmpty:(NSObject *)obj{
    
    if (obj == nil) {
        return YES;
    }
    
    if (obj == NULL){
        return YES;
    }
    
    if ([obj isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    
    return NO;
    
}

/**
 *  判断数组是否为NSArray类型
 *
 *  @param array 判断的数组
 *
 *  @return YES：是nil，null， NO：不是NSArray类型
 */
+ (BOOL)arrayIsNull:(NSArray *)array{
    
    if (array == nil) {
        return YES;
    }
    
    if (array == NULL){
        return YES;
    }
    
    if ([array isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return NO;
    
}



/**
 *  判断该字典是否为空
 *
 *  @param dict 判断的字典
 *
 *  @return NO：不为空 YES：为空
 */
+ (BOOL)dictIsEmpty:(NSDictionary *)dict{
    if (dict == nil) {
        return YES;
    }
    
    if (dict == NULL){
        return YES;
    }
    
    if ([dict isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([dict isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([dict isKindOfClass:[NSDictionary class]] && dict.count > 0) {
        return NO;
    }
    
    return YES;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

//NSUserDefaults
+ (id)getObjectFromUD:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)saveObjectToUD:(id)value key:(NSString *)key {
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutaDic = [value mutableCopy];
        NSArray *allkeys = mutaDic.allKeys;
        for (int i=0; i<[allkeys count]; i++) {
            NSString *key = [allkeys objectAtIndex:i];
            
            NSString *value = [mutaDic objectForKey:key];
            if ([CommonUtil isEmpty:value]) {
                [mutaDic setObject:@"" forKey:key];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:mutaDic forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteObjectFromUD:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  存储自动进入下一页信息
 *
 *  @param classname 所在页面
 *  @param otherDic  其他信息
 */
+(void)saveAutoPushInfoWithClass:(Class)classname otherMessage:(NSDictionary *)otherDic{

    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    [infoDic addEntriesFromDictionary:otherDic];
    [infoDic setValue:NSStringFromClass(classname) forKey:@"class"];
    
    [self saveObjectToUD:infoDic key:@"loginParam"];
}

//MD5加密
+ (NSString *)md5:(NSString *)password {
    const char *original_str = [password UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //NSString *platform = [NSString stringWithUTF8String:machine];二者等效
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

/**
 * 判断是否登录
 */
- (BOOL)isLogin {
    return [self isLogin:YES];
}

/**
 *  判断是否登录
 *
 *  @param needLogin YES:未登录就弹出登录页面， NO：未登录不弹出登录页面
 *
 *  @return YES：已经登录 NO：未登录
 */
- (BOOL)isLogin:(BOOL)needLogin {
    BOOL isLogin = NO;
//    if (![CommonUtil isEmpty:appDelegate.userId]) {
//        isLogin = YES;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //清除需要自动进入下一页的信息
//            [CommonUtil deleteObjectFromUD:@"loginParam"];
//        });
//    } else {
//        //需要进行登录
//        if (needLogin) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"needlogin" object:nil];
//        }
//    }
    
    return isLogin;
}

/**
 *  其他地方登录过，需要重新登录
 *
 *  @param needLogin YES:需要跳转到登录   NO：不需要跳转到登录页面
 */
- (void)reloadLogin:(BOOL)needLogin{
//    [CommonUtil deleteObjectFromUD:@"userInfo"];
//    [CommonUtil deleteObjectFromUD:@"loginName"];
//    [CommonUtil deleteObjectFromUD:@"password"];
//    appDelegate.userId = @"";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLogin" object:nil];
    
    if (needLogin) {
        //需要登录
        [[NSNotificationCenter defaultCenter] postNotificationName:@"needlogin" object:nil];
    }
}

/**
 *  获取用户userId
 *
 *  @return userId
 */
- (NSString *)getLoginUserid {
//    return appDelegate.userId;
    return @"";
}

/**
 *  获取用户的custId
 *
 *  @return custId
 */
- (NSString *)getUserCustId {
//    UserInfo *info = [[UserInfo alloc] initWithDict:[CommonUtil getObjectFromUD:@"userInfo"]];
//    
//    if (info) {
//        return info.custId;
//    }
//    
    return nil;
}

/**
 *  去除emoji表情
 *
 *  @param text 内容
 *
 *  @return
 */
+ (NSString *)disableEmoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
/****************** UIView方法 ******************/

/**
 *  添加页面边框，圆角属性
 *
 *  @param view         添加属性的view
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *  @param cornerRadius 圆角
 */
+ (void)addViewAttr:(id)view borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;{
    
    if (view == nil){
        return;
    }
    
    UIView *attrView = (UIView *)view;
    
    if (borderWidth > 0){
        attrView.layer.borderWidth = borderWidth;
        attrView.layer.borderColor = borderColor.CGColor;
    }
    
    if (cornerRadius > 0) {
        attrView.layer.cornerRadius = cornerRadius;
    }
    
    if (borderWidth > 0 || cornerRadius > 0) {
        attrView.layer.masksToBounds = YES;
    }
    
}

/**
 *  给view添加圆角
 *
 *  @param view       需要添加圆角的view
 *  @param radius     圆角度数
 *  @param rectCorner 给哪几个角添加 UIRectCornerTopLeft，UIRectCornerTopRight，UIRectCornerBottomLeft，UIRectCornerBottomRight，UIRectCornerAllCorners
 *  @param lineColor  线的颜色
 */
+ (void)addViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)radius
                 rectCorner:(UIRectCorner)rectCorner lineColor:(UIColor *)lineColor{
    
//    UIRectCorner rec = UIRectCornerBottomLeft | UIRectCornerBottomRight ;
    //颜色
    [lineColor set]; //设置线条颜色
    
    CGRect frame = view.bounds;
    frame.size.width += 2;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:rectCorner cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.lineWidth = 1;
    view.layer.mask = maskLayer;
}


/**
 *  给view添加阴影
 *
 *  @param view          需要处理的view
 *  @param shadowOffset  阴影偏移量, (CGSizeMake(4,4))x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
 *  @param shadowOpacity 阴影透明度
 *  @param shadowColor   阴影颜色
 *  @param shadowRadius  阴影半径
 */
+ (void)addViewShadow:(UIView *)view shadowOffset:(CGSize)shadowOffset
                 shadowOpacity:(CGFloat)shadowOpacity shadowColor:(UIColor *)shadowColor
         shadowRadius:(CGFloat)shadowRadius{
    
    view.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = shadowOffset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    view.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    view.layer.masksToBounds = NO;
}

// 记录debug数据(log)
+ (void)writeDebugLogName:(NSString *)name data:(NSString *)data
{
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 查找文件（设置目录）
    NSArray *directoryPaths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 传递 0 代表是找在Documents 目录下的文件。
    NSString *documentDirectory = [directoryPaths  objectAtIndex:0];
    // DBNAME 是要查找的文件名字，文件全名
    NSString *filePath = [documentDirectory  stringByAppendingPathComponent:@"debug.text"];
    NSLog(@"filePath  %@",filePath);
    // 用这个方法来判断当前的文件是否存在，如果不存在，就创建一个文件
    if ( ![fileManager fileExistsAtPath:filePath])
    {
        [fileManager createFileAtPath:filePath  contents:nil attributes:nil];
    }
    
    // 获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formatter stringFromDate:[NSDate date]];
    
    // 获取数据
    //    NSString* fileName = [documentDirectory stringByAppendingPathComponent:@"debug.text"];
    NSString *str = [NSString stringWithFormat:@"%@"@"  [%@]  "@"%@"@"\r\n",time,name,data];
    NSData *fileData = [str dataUsingEncoding:NSUTF8StringEncoding];
    //    [fileData writeToFile:fileName atomically:YES];
    
    // 追加写入数据
    NSFileHandle  *outFile;
    outFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    [outFile writeData:fileData];
    
    //关闭读写文件
    [outFile closeFile];
}

// 根据文字，字号及固定宽(固定高)来计算高(宽) 需要计算什么，什么传值“0”
+ (CGSize)sizeWithString:(NSString *)text
                fontSize:(CGFloat)fontsize
               sizewidth:(CGFloat)width
              sizeheight:(CGFloat)height
{
    
    // 用何种字体显示
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([self isEmpty:text]) {
         return expectedLabelSize;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment=NSTextAlignmentLeft;
        
        NSAttributedString *attributeText=[[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle}];
        CGSize labelsize = [attributeText boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        expectedLabelSize = CGSizeMake(ceilf(labelsize.width),ceilf(labelsize.height));
    } else {
        expectedLabelSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, height) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    // 计算出显示完内容的最小尺寸
    
    return expectedLabelSize;
}

+(void)sizeWithString:(NSString*)content lineSpacing:(CGFloat)lineSpacing fontsize:(CGFloat)fontSize size:(CGSize)size muStr:(void(^)(CGSize contextSize ,NSAttributedString *muStr))complete{

    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if (lineSpacing) {
       [style setLineSpacing:lineSpacing];//行间距
    }
    style.alignment = NSTextAlignmentLeft;//对齐方式
    style.lineBreakMode = NSLineBreakByWordWrapping;//拆行方式
    NSAttributedString *muString = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    CGSize stringSize = [muString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    complete(stringSize,muString);
}


// 窗口弹出动画
+ (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.75;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [aView.layer addAnimation:animation forKey:nil];
}

/**
 *  数组随机排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 排序好的数组
 */
+ (NSMutableArray *) randomizedArrayWithArray:(NSArray *)array {
    
    NSMutableArray *results = [[NSMutableArray alloc]initWithArray:array];
    
    NSInteger i = results.count;
    
    while(--i > 0) {
        
        int j = rand() % (i+1);
        
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
        
    }
    
    return results;
    
}

/****************** 关于图像方法 <S> ******************/

//图片方向处理
+ (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return [CommonUtil scaleImage:img minLength:600];
}


+ (UIImage *)scaleImage:(UIImage *)image minLength:(float)length
{
    if (image.size.width <= length || image.size.height <= length) {
        return image;
    }
    
    CGFloat scaleSize = MAX(length/image.size.width, length/image.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/****************** 关于颜色方法 <S> ******************/

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

/**
 *  替换存储的时间
 */
+(void)replaceUserDefaultTime{
    
    NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
    
    NSString * time = [CommonUtil getStringForDate:[NSDate date]];
    NSArray * array = [time componentsSeparatedByString:@" "];
    NSString * dateNum = [NSString stringWithFormat:@"%@",[array firstObject]];
//    NSString * userDateNum = [NSString stringWithFormat:@"%@",[users stringForKey:@"dateNum"]];
    NSString * nowTime = [NSString stringWithFormat:@"%@",[array lastObject]];
    
    
    //设置已点击
    [users setObject:@"touch" forKey:@"touchAfterZero"];
    
    //小于10点点击了
    if ([nowTime compare:@"10:00:00"] == NSOrderedAscending){
        
        [users removeObjectForKey:@"dateNum"];
        
    }else{
        
        [users setObject:dateNum forKey:@"dateNum"];
    }

    [users synchronize];

}


/**
 *  获取图片
 *
 *  @param imageView   需要展示的imageView
 *  @param url         链接字符串
 *  @param placeholder 加载前展示图片
 */
+(void)setImageForImageView:(UIImageView*)imageView withUrl:(NSString*)url placeholderImage:(UIImage*)placeholder withContentMode:(NSString *)contentMode{

    //图片路径拼凑
    if (![url hasPrefix:@"http"]) {
        
        url = [NSString stringWithFormat:@"%@%@", IMAGE_HOST,url];
    }
    
    [self setSDWebImageProperties];
    
    if ([contentMode isEqualToString:@"0"]) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }];
    }else{
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
    }

//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

}

+(void)setImageForButton:(UIButton*)button withUrl:(NSString*)url placeholderImage:(UIImage*)placeholder state:(UIControlState)state type:(NSInteger)type{

    //图片路径拼凑
    if (![url hasPrefix:@"http"]) {
        
        url = [NSString stringWithFormat:@"%@%@", IMAGE_HOST,url];
    }
    
    [self setSDWebImageProperties];
    
//    if (type) {
//        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:state];
//    }else
//        [button sd_setImageWithURL:[NSURL URLWithString:url] forState:state];
}


/**
 *  设置sdwebImage属性(关闭解压缩功能)
 */
+(void)setSDWebImageProperties{
//    
    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    //    [[SDImageCache sharedImageCache] setShouldCacheImagesInMemory:NO];
}


/**
 *  判断银行卡的背景图片
 *
 *  @param bankName 银行名称
 *
 *  @return 图片名称
 */
+(NSString*)selectedBankCardBgImageWithBankName:(NSString*)color{

    NSString * bankImage = @"";
    
    if ([color isEqualToString:@"red"]) {
        
        bankImage = @"bankRedBg";
        
    }else if ([color isEqualToString:@"blue"]){
        
        bankImage = @"bankbluebg";
        
    }else if ([color isEqualToString:@"green"]){
        bankImage = @"bankGreenBg";
        
    }else{
        
        bankImage = @"bankbluebg";
    }
    
    return bankImage;
}


/**
 *  整理价格textField 配合(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 *
 *  @param num       几位数价格
 *  @param textField textfield
 *  @param range     range
 *  @param string    string
 *
 *  @return yes or no
 */
+ (BOOL)sortOutNumber:(NSInteger)num TextField:(UITextField * )textField range:(NSRange)range string:(NSString *)string{
    
    //总长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                
            }
            
            if (single == '.' && [textField.text length]==1 && [textField.text isEqualToString:@"0"]) {
                return YES;
            }
            if (single == '0' &&[textField.text length]==1 && [textField.text isEqualToString:@"0"]) {
                return NO;
            }
            
            
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt > 2){
                        return NO;
                    }
                }
                
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    
    //超过6位不可输入
    if (strLength > num) {
        NSString *text = nil;
        
        //获取当前输入内容
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }else{
            text = [textField.text substringToIndex:range.location];
        }
        
        if ([text doubleValue] >= pow(10, num)) {
            return NO;
        }
        
    }
    
    
    return YES;
    
}

/**
 *  通过查找subview所在的viewcontroller 弹出提示
 *
 *  @param subView subView
 *  @param toast   提示类容
 */
+(void)makeToastWithSubView:(UIView *)subView withToast:(NSString *)toast{

    for (UIView *view = [subView superview];view; view = [view superview]) {
        UIResponder *responder = [view nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)responder;
            [controller makeToast:toast];
        }
    }
    
}

@end
