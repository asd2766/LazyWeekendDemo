//
//  IndexItemTableViewCell.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "IndexItemTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonUtil.h"
#import "Consts.h"
#import "JQPaddingLabel.h"

@interface IndexItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet JQPaddingLabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet JQPaddingLabel *priceLabel;

// 参数
@property (strong, nonatomic) NSMutableDictionary *activityDic;
@end

@implementation IndexItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.activityDic = [NSMutableDictionary dictionary];
    
    [self.collectionBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    // 添加边框，圆角
    [CommonUtil addViewAttr:self.timeLabel borderWidth:1 borderColor:RGB(200, 200, 200) cornerRadius:5];
    [CommonUtil addViewAttr:self.collectionBtn borderWidth:1 borderColor:RGB(200, 200, 200) cornerRadius:5];
    [CommonUtil addViewAttr:self.priceLabel borderWidth:1 borderColor:RGB(200, 200, 200) cornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  设置顶部图片
 *
 *  @param imageUrl 图片url
 */
- (void)setHeaderImage:(NSString *)imageUrl {
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}

/**
 *  设置cell内容
 *
 *  @param title         标题
 *  @param location      目的地
 *  @param time          时间
 *  @param collectionNum 收藏人数
 *  @param price         价格
 *  @param delegate      代理
 *  @param id            活动id
 */
- (void)setTitle:(NSString *)title location:(NSString *)location
            time:(NSString *)time collectionNum:(NSString *)collectionNum
           price:(NSString *)price delegate:(id)delegate id:(NSString *)id{
    
    // 标题
    self.titleLabel.text = [CommonUtil isEmpty:title] ? @"暂无" : title;
    
    // 目的地
    location = [CommonUtil isEmpty:location] ? @"暂无" : location;
    self.locationLabel.text = [NSString stringWithFormat:@"目的地：%@", location];
    
    // 日期
    self.timeLabel.edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    self.timeLabel.text = [CommonUtil isEmpty:time] ? @" -- " : [NSString stringWithFormat:@"%@", time];
    
    // 收藏
    NSString *desc = [NSString stringWithFormat:@"%d人收藏  ", [collectionNum intValue]];
    [self.collectionBtn setTitle:desc forState:UIControlStateNormal];
    
    // 价格
    self.priceLabel.edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    price = [CommonUtil isEmpty:price] ? @" -- " : price;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", price];
    
    self.delegate = delegate;
    
    // 存储数据
    [self.activityDic setObject:title forKey:@"title"];
    [self.activityDic setObject:location forKey:@"location"];
    [self.activityDic setObject:time forKey:@"time"];
    [self.activityDic setObject:collectionNum forKey:@"collectionNum"];
    [self.activityDic setObject:price forKey:@"price"];
    [self.activityDic setObject:id forKey:@"id"];
}


/**
 设置是否收藏

 @param isCollection YES: 收藏状态  NO: 未收藏
 */
- (void)updateCollectionStatus:(Boolean)isCollection {
    self.collectionBtn.selected = isCollection;
}

/**
 点击收藏

 @param sender
 */
- (IBAction)clickForCollection:(id)sender {
    self.collectionBtn.selected = !self.collectionBtn.selected;
    
    [UIView beginAnimations:@"scale"context:nil];
    [UIView setAnimationDuration:.25f];
    self.collectionBtn.imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.collectionBtn.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.collectionBtn.imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.collectionBtn.imageView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView commitAnimations];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionActivity:)]) {
        [self.delegate collectionActivity:self.activityDic];
    }
}

@end
