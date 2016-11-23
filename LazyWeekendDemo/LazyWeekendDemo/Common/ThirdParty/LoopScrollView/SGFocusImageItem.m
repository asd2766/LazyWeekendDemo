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
            self.title = [dict objectForKey:@"title"];
            self.imageUrl = [dict objectForKey:@"imageUrl"];
            self.linkStr = [dict objectForKey:@"linkUrl"];
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
