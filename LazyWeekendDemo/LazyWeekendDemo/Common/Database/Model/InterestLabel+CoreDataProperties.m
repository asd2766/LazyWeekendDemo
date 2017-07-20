//
//  InterestLabel+CoreDataProperties.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/20.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "InterestLabel+CoreDataProperties.h"

@implementation InterestLabel (CoreDataProperties)

+ (NSFetchRequest<InterestLabel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"InterestLabel"];
}

@dynamic userId;
@dynamic labelId;
@dynamic labelName;

@end
