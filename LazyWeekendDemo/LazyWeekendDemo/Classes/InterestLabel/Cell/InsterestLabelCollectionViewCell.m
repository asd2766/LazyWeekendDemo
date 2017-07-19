//
//  InsterestLabelCollectionViewCell.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "InsterestLabelCollectionViewCell.h"

@interface InsterestLabelCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

@end

@implementation InsterestLabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/**
 设置cell内容

 @param image 图片
 @param name 名称
 */
- (void)updateContentWithImage:(UIImage *)image name:(NSString *)name {
    if (image != nil) {
        self.iconImageView.image = image;
    }
    
    [_nameBtn setTitle:name forState:UIControlStateNormal];
}

/**
 cell是否选中

 @param isSelected YES: 选中 NO: 未选中
 @param image isSelected = YES 表示选中的图片, isSelected = NO 表示未选中的图片
 */
- (void)cellIsSelected:(Boolean)isSelected image:(UIImage *)image {
    self.nameBtn.selected = isSelected;
    
    if (image != nil) {
        self.iconImageView.image = image;
    }
}
@end
