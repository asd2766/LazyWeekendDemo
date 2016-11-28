/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "Consts.h"
#import "UIViewController+Toast.h"
#import "CommonUtil.h"
#import "CommonUtil+Date.h"
#import "CommonUtil+Files.h"
#import "CommonUtil+Check.h"
#import "CommonUtil+Calculate.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "CoreData+MagicalRecord.h"
#import "MBProgressHUD.h"
#import "NoDataView.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "UIView_extra.h"

#import "CoreData+MagicalRecord.h"

typedef NS_ENUM(NSInteger, NormalAlertType) {
    NormalAlertWrongType,   //错误提示框
    NormalAlertRightType,   //正确提示框
    NormalAlertSelectedType  //弹出认证
};

@interface BaseViewController : UIViewController<MBProgressHUDDelegate>{
    long chooseImageCount;
}

@property (strong, nonatomic) MBProgressHUD *progressHUD;//加载框（菊花转）

@property (strong, nonatomic) NoDataView *noDataView;//没有数据页面

/**
 *  添加正在加载框
 *
 */
- (void)showProgressView:(UIView *)view;

/**
 *  隐藏加载框
 */
- (void)hideProgressView;

/**
 *  设置无数据页面的文字信息
 *
 *  @param title 标题
 *  @param desc  描述文字
 */
- (void)setNodataTitle:(NSString *)title desc:(NSString *)desc;

/** 显示通用弹框
 * @param title         标题
 * @param smallTitle    小标题
 * @param detail        详细内容
 * @param type  类型（正确，错误）
 */
- (void)showNormalAlertView:(NSString *)title smallTitle:(NSString *)smallTitle
                     detail:(NSString *)detail alertType:(NormalAlertType)alertType;


/**
 *  是否显示没有数据页面
 *
 *  @param array 数据
 *  @param frame 显示页面的frame
 *  @param view  父页面
 *  @param title 标题
 *  @param desc  描述
 */
- (void)showNoDataViewBydataArray:(NSArray *)array frame:(CGRect)frame view:(UIView *)view
                            title:(NSString *)title desc:(NSString *)desc;


- (IBAction)backClick:(id)sender;

- (IBAction)backClickByDimiss:(id)sender;

//拨打电话
- (IBAction)clickForCall:(id)sender;


@end
