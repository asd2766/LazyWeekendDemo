//
//  Collections+CoreDataProperties.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/25.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Collections+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Collections (CoreDataProperties)

+ (NSFetchRequest<Collections *> *)fetchRequest;

@property (nonatomic) int64_t userId;
@property (nullable, nonatomic, copy) NSString *activityTitle;
@property (nonatomic) int64_t activityId;
@property (nullable, nonatomic, copy) NSString *activityPrice;
@property (nullable, nonatomic, copy) NSString *activityLocation;
@property (nullable, nonatomic, copy) NSString *activityTime;
@property (nullable, nonatomic, copy) NSString *activityImageUrl;

@end

NS_ASSUME_NONNULL_END
