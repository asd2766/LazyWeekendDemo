//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"
#import "CommonUtil.h"
#import "Consts.h"

@implementation SGFocusImageItem

- (id)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageUrl = imageUrl;
        self.tag = tag;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            self.title = [dict objectForKey:@"adv_title"];
            self.imageUrl = [dict objectForKey:@"adv_content"];
            self.linkStr = [dict objectForKey:@"adv_url"];
            self.tag = tag;
        }
    }
    return self;
}

- (id)initWithDict2:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
//            self.title = [dict objectForKey:@"title"];
            self.imageUrl = [CommonUtil isEmpty:dict[@"url"]]?@"":dict[@"url"];
            self.linkStr = [CommonUtil isEmpty:dict[@"linkUrl"]]?@"":dict[@"linkUrl"];
            self.linkStr = [CommonUtil isEmpty:dict[@"type"]]?@"":dict[@"type"];
            self.tag = tag;
        }
    }
    return self;
}

- (id)initWithDict3:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
         
            self.imageUrl = [CommonUtil isEmpty:dict[@"filePath"]]?@"":dict[@"filePath"];
            self.tag = tag;
        }
    }
    return self;
}


- (instancetype)initWithDictType:(NSDictionary *)dict tag:(NSInteger)tag{

    if (self = [super init]) {
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [CommonUtil isEmpty:[dict[@"adv_content"] description]]?@"":[dict[@"adv_content"] description];
            self.fowardStyle = [CommonUtil isEmpty:[dict[@"forward_style"] description]]?@"":[dict[@"forward_style"] description];
            self.param = [CommonUtil isEmpty:[dict[@"forward_param"] description]]?@"":[dict[@"forward_param"] description];
            self.forwardUrl = [CommonUtil isEmpty:[dict[@"forward_url"] description]]?@"":[dict[@"forward_url"] description];
            
            if (![self.imageUrl hasPrefix:@"https"]) {
                self.imageUrl = [NSString stringWithFormat:@"%@%@", IMAGE_HOST, self.imageUrl];
            }
            
            self.tag = tag;
        }
        
        
    }
    
    return self;
    
}

/**
 *  初始化男鞋区，女鞋区等海报数据
 *
 *  @param dict 字典类
 *  @param tag
 *
 *  @return
 */
- (instancetype)initWithPosterDic:(NSDictionary *)dict tag:(NSInteger)tag {
    if (self = [super init]) {
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [CommonUtil isEmpty:[dict[@"file_path"] description]]?@"":[dict[@"file_path"] description];
            self.forwardUrl = [CommonUtil isEmpty:[dict[@"forward_url"] description]]?@"":[dict[@"forward_url"] description];
            
            if (![self.imageUrl hasPrefix:@"https"]) {
                self.imageUrl = [NSString stringWithFormat:@"%@%@", IMAGE_HOST, self.imageUrl];
            }
            
            self.tag = tag;
        }
        
        
    }
    
    return self;
}

-(instancetype)initWithNewsDicType:(NSDictionary *)dict tag:(NSInteger)tag{

    self = [super init];
    if (self) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.title = [CommonUtil isEmpty:dict[@"msg_content"]]?@"":dict[@"msg_content"];
            self.fowardStyle = [CommonUtil isEmpty:[dict[@"forward_style"] description]]?@"":[dict[@"forward_style"] description];
            self.param = [CommonUtil isEmpty:[dict[@"forward_param"] description]]?@"":[dict[@"forward_param"] description];
            self.forwardUrl = [CommonUtil isEmpty:[dict[@"forward_url"] description]]?@"":[dict[@"forward_url"] description];
            self.tag = tag;
        }
    }
    
    return self;
    
}

- (id)initWithImage:(UIImage *)image tag:(NSInteger)tag{
    self = [super init];
    if (self)
    {
        self.image = image;
        self.tag = tag;
    }
    return self;
}

@end
