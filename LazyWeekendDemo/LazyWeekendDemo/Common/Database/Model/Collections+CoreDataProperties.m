//
//  Collections+CoreDataProperties.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/25.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Collections+CoreDataProperties.h"

@implementation Collections (CoreDataProperties)

+ (NSFetchRequest<Collections *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Collections"];
}

@dynamic userId;
@dynamic activityTitle;
@dynamic activityId;
@dynamic activityPrice;
@dynamic activityLocation;
@dynamic activityTime;
@dynamic activityImageUrl;

@end
