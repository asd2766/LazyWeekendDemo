//
//  CommonUtil.h
//  wedding
//
//  Created by duanjycc on 14/11/14.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^BackUserIdentifyState)(NSString* identifyState);

@interface CommonUtil : NSObject

/**
 *  共同处理类单例实例化
 *
 *  @return 共同处理类单例
 */
+ (instancetype)currentUtil;

// 判断空字符串
+ (BOOL)isEmpty:(NSString *)string;
+ (NSString *)stringForID:(id)objectid;

/**
 *  判断是否为是nil，null
 *
 *  @param obj 判断的对象
 *
 *  @return YES：是nil，null， NO：不是nil，null类型
 */
+ (BOOL)isNullEmpty:(NSObject *)obj;

/**
 *  判断数组是否为空
 *
 *  @param array 判断的数组
 *
 *  @return YES：为空， NO：不为空
 */
+ (BOOL)arrayIsEmpty:(NSArray *)array;


/**
 *  判断数组是否为NSArray类型
 *
 *  @param array 判断的数组
 *
 *  @return YES：是nil，null， NO：不是NSArray类型
 */
+ (BOOL)arrayIsNull:(NSArray *)array;

/**
 *  判断该字典是否为空
 *
 *  @param dict 判断的字典
 *
 *  @return NO：不为空 YES：为空
 */
+ (BOOL)dictIsEmpty:(NSDictionary *)dict;

/**
 *  替换字典中的nsnull类型
 *
 *  @param dict 判断的字典
 *
 *  @return 替换后的字典
 */
+(NSDictionary *)nullDic:(NSDictionary *)myDic;
/**
 *  替换数组中的nsnull类型
 *
 *  @param dict 判断的数组
 *
 *  @return 替换后的数组
 */
+(NSArray *)nullArr:(NSArray *)myArr;
/**
 *  去除左右空格
 *
 *  @param str 需要去除左右空格的字符串
 *
 *  @return 去除左右空格之后的字符串
 */
+ (NSString *)trimStr:(NSString *)str;


//读取 NSUserDefaults
+ (id)getObjectFromUD:(NSString *)key;

//存储 NSUserDefaults
+ (void)saveObjectToUD:(id)value key:(NSString *)key;
+ (void)deleteObjectFromUD:(NSString *)key;


/**
 *  存储自动进入下一页信息
 *
 *  @param classname 所在页面
 *  @param otherDic  其他信息
 */
+(void)saveAutoPushInfoWithClass:(Class)classname otherMessage:(NSDictionary*)otherDic;

//MD5加密
+ (NSString *)md5:(NSString *)password;

/**
 *  获取设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

/* 判断是否登录
 * @return YES：已经登录 NO：未登录
 */
- (BOOL)isLogin;

/**
 *  判断是否登录
 *
 *  @param needLogin YES:未登录就弹出登录页面， NO：未登录不弹出登录页面
 *
 *  @return YES：已经登录 NO：未登录
 */
- (BOOL)isLogin:(BOOL)needLogin;

/**
 *  其他地方登录过，需要重新登录
 *
 *  @param needLogin YES:需要跳转到登录   NO：不需要跳转到登录页面
 */
- (void)reloadLogin:(BOOL)needLogin;

/**
 *  获取用户userId
 *
 *  @return userId
 */
- (NSString *)getLoginUserid;

/**
 *  获取用户的custId
 *
 *  @return custId
 */
- (NSString *)getUserCustId;

/**
 *  去除emoji表情
 *
 *  @param text 内容
 *
 *  @return
 */
+ (NSString *)disableEmoji:(NSString *)text;

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
        borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
/**
 *  给view添加圆角
 *
 *  @param view       需要添加圆角的view
 *  @param radius     圆角度数
 *  @param rectCorner 给哪几个角添加 UIRectCornerTopLeft，UIRectCornerTopRight，UIRectCornerBottomLeft，UIRectCornerBottomRight，UIRectCornerAllCorners
 *  @param lineColor  线的颜色
 */
+ (void)addViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)radius
                 rectCorner:(UIRectCorner)rectCorner lineColor:(UIColor *)lineColor;

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
         shadowRadius:(CGFloat)shadowRadius;


//// Date 转换 NSString (默认格式：自定义)
//+ (NSString *)getStringForDate:(NSDate *)date format:(NSString *)format;
//
//// NSString 转换 Date (默认格式：自定义)
//+ (NSDate *)getDateForString:(NSString *)string format:(NSString *)format;


// 记录debug数据(log)
+ (void)writeDebugLogName:(NSString *)name data:(NSString *)data;


// 根据文字，字号及固定宽(固定高)来计算高(宽)
+ (CGSize)sizeWithString:(NSString *)text
                fontSize:(CGFloat)fontsize
               sizewidth:(CGFloat)width
              sizeheight:(CGFloat)height;

+(void)sizeWithString:(NSString*)content
          lineSpacing:(CGFloat)lineSpacing
             fontsize:(CGFloat)fontSize
                 size:(CGSize)size
                muStr:(void(^)(CGSize contextSize ,NSAttributedString *muStr))complete;

// 窗口弹出动画
+ (void)shakeToShow:(UIView*)aView;

/****************** 关于数据方法 <S> ******************/
/**
 *  数组随机排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 排序好的数组
 */
+ (NSMutableArray *) randomizedArrayWithArray:(NSArray *)array;

/****************** 关于图像方法 <S> ******************/

//图片方向处理
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

//缩放图片
+ (UIImage *)scaleImage:(UIImage *)image minLength:(float)length;

/****************** 关于颜色方法 <S> ******************/

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  替换存储的时间
 */
+(void)replaceUserDefaultTime;


/**
 *  获取图片
 *
 *  @param imageView   需要展示的imageView
 *  @param url         链接字符串
 *  @param placeholder 加载前展示图片
 *  @param contentMode 图片模式 0. aspectFit  其他
 */
+(void)setImageForImageView:(UIImageView*)imageView withUrl:(NSString*)url placeholderImage:(UIImage*)placeholder withContentMode:(NSString*)contentMode;

/**
 *  设置button的图片
 *
 *  @param button      按钮
 *  @param url         链接
 *  @param placeholder nil
 *  @param state       状态
 *  @param type        0设置image 1设置backGround
 */
+(void)setImageForButton:(UIButton*)button withUrl:(NSString*)url placeholderImage:(UIImage*)placeholder state:(UIControlState)state type:(NSInteger)type;

/**
 *  设置sdwebImage属性(关闭解压缩功能)
 */
+(void)setSDWebImageProperties;

/**
 *  判断银行卡的背景图片
 *
 *  @param color 银行颜色
 *
 *  @return 图片名称
 */
+(NSString*)selectedBankCardBgImageWithBankName:(NSString*)color;

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
+ (BOOL)sortOutNumber:(NSInteger)num TextField:(UITextField * )textField range:(NSRange)range string:(NSString *)string;

/**
 *  通过查找subview所在的viewcontroller 弹出提示
 *
 *  @param subView subView
 *  @param toast   提示类容
 */
+(void)makeToastWithSubView:(UIView*)subView withToast:(NSString*)toast;


@end
