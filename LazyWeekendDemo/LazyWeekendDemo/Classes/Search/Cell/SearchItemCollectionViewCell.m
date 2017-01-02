//
//  SearchItemCollectionViewCell.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/12/2.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "SearchItemCollectionViewCell.h"
#import "CommonUtil.h"

@interface SearchItemCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SearchItemCollectionViewCell

- (void)awakeFromNib {
    
}

/**
 *  设置cell内容
 *
 *  @param imageUrl   图片
 *  @param name       名称
 *  @param isSelected YES：选中 NO：未选中
 */
- (void)setImage:(NSString *)imageUrl name:(NSString *)name
      isSelected:(BOOL)isSelected {
    // icon图片
    UIImage *image = [UIImage imageNamed:imageUrl];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];// 始终根据Tint Color绘制图片，忽略图片的颜色信息。
    self.iconImageView.image = image;
    
    self.nameLabel.text = name;
    
    // 设置选中效果
    if (isSelected) {
        // 选中为白色
        self.iconImageView.tintColor = [UIColor whiteColor]; // 改变图片的颜色
        self.nameLabel.textColor = [UIColor whiteColor];
    } else {
        self.iconImageView.tintColor = [CommonUtil colorWithHexString:@"#9b9b9b"];
        self.nameLabel.textColor = [CommonUtil colorWithHexString:@"#9b9b9b"];
    }
}

@end
