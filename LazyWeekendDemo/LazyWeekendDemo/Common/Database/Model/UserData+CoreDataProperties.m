//
//  UserData+CoreDataProperties.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UserData+CoreDataProperties.h"

@implementation UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserData"];
}

@dynamic id;
@dynamic nickName;
@dynamic phone;
@dynamic password;
@dynamic status;
@dynamic sex;

@end
