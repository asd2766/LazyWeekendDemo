//
//  CollectionItemTableViewCell.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/25.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionItemTableViewCell : UITableViewCell

/**
 更新cell显示内容
 
 @param imageUrl 图片
 @param title 标题
 @param location 地址
 */
- (void)updateCellByImageUrl:(NSString *)imageUrl title:(NSString *)title
                    location:(NSString *)location;
@end
