//
//  CollectionItemTableViewCell.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/25.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "CollectionItemTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation CollectionItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 更新cell显示内容

 @param imageUrl 图片
 @param title 标题
 @param location 地址
 */
- (void)updateCellByImageUrl:(NSString *)imageUrl title:(NSString *)title
                    location:(NSString *)location {
    // 图片
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    // 标题
    self.titleLabel.text = title;
    
    // 地点
    self.locationLabel.text = [NSString stringWithFormat:@"地址: 集合地: %@", location];
}

@end
