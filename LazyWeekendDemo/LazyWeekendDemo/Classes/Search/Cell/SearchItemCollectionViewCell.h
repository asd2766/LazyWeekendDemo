//
//  SearchItemCollectionViewCell.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/12/2.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchItemCollectionViewCell : UICollectionViewCell

/**
 *  设置cell内容
 *
 *  @param imageUrl   图片
 *  @param name       名称
 *  @param isSelected YES：选中 NO：未选中
 */
- (void)setImage:(NSString *)imageUrl name:(NSString *)name
      isSelected:(BOOL)isSelected;

@end
