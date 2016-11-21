//
//  TopicItem.h
//  Zhaoxie
//
//  Created by 吴筠秋 on 15/9/3.
//  Copyright (c) 2015年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicItem : UIView

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;//内容
@property (strong, nonatomic) IBOutlet UILabel *descLabel;//描述

//参数
@property (strong, nonatomic) NSString *type;//类型， 1推荐，0最新
@property (strong, nonatomic) NSString *content;//内容
@property (nonatomic, assign) NSInteger index;

- (id)initWithType:(NSString *)type content:(NSString *)content index:(NSInteger)index;
- (void)setType:(NSString *)type content:(NSString *)content index:(NSInteger)index;
@end
