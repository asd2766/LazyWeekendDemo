//
//  UserData+CoreDataProperties.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UserData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString id;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nonatomic) int32_t phone;
@property (nullable, nonatomic, copy) NSString *password;
@property (nonatomic) int64_t status;
@property (nonatomic) int16_t sex;

@end

NS_ASSUME_NONNULL_END
