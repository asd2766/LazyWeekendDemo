//
//  IndexItemTableViewCell.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexItemTableViewCell : UITableViewCell

/**
 *  设置顶部图片
 *
 *  @param imageUrl 图片url
 */
- (void)setHeaderImage:(NSString *)imageUrl;

/**
 *  设置cell内容
 *
 *  @param title         标题
 *  @param location      目的地
 *  @param time          时间
 *  @param collectionNum 收藏人数
 *  @param price         价格
 */
- (void)setTitle:(NSString *)title location:(NSString *)location
            time:(NSString *)time collectionNum:(NSString *)collectionNum
           price:(NSString *)price;
@end
