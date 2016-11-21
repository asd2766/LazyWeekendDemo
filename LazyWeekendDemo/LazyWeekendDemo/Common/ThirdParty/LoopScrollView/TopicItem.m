//
//  TopicItem.m
//  Zhaoxie
//
//  Created by 吴筠秋 on 15/9/3.
//  Copyright (c) 2015年 吴筠秋. All rights reserved.
//

#import "TopicItem.h"

@implementation TopicItem

- (id)initWithType:(NSString *)type content:(NSString *)content index:(NSInteger)index
{
    self = [super init];
    if (self) {
        
        [self setType:type content:content index:index];
    }
    
    return self;
}

- (void)setType:(NSString *)type content:(NSString *)content index:(NSInteger)index{
    self.type = type;
    self.content = content;
    self.index = index;
    self.tag = index;
    
    //设置边框颜色
    self.descLabel.layer.borderColor = self.descLabel.textColor.CGColor;
    self.descLabel.layer.borderWidth = 1;
    self.descLabel.layer.cornerRadius = 3;
    self.descLabel.layer.masksToBounds = YES;
    
    //设置内容
    self.contentLabel.text = content;
    if ([type intValue] == 0) {
        self.descLabel.text = @"最新";
    }else if ([type intValue] == 1){
        self.descLabel.text = @"推荐";
    }
}
@end
