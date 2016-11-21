//
//  UserInfo.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id",
             @"userName" : @"userName"};
}

@end
