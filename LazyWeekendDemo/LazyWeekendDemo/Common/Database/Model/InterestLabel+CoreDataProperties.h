//
//  InterestLabel+CoreDataProperties.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/20.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "InterestLabel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface InterestLabel (CoreDataProperties)

+ (NSFetchRequest<InterestLabel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *labelId;
@property (nullable, nonatomic, copy) NSString *labelName;

@end

NS_ASSUME_NONNULL_END
