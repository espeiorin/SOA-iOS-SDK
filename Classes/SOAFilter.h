//
//  SOAFilter.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOAFilter : NSObject

@property (nonatomic, strong, readonly) NSString *condition;
@property (nonatomic, strong, readonly) NSString *field;
@property (nonatomic, strong, readonly) id value;

+ (instancetype) where:(NSString *)field notEqualTo:(id)value;
+ (instancetype) where:(NSString *)field equalTo:(id)value;
+ (instancetype) where:(NSString *)field greaterOrEqualTo:(id)value;
+ (instancetype) where:(NSString *)field greaterThan:(id)value;
+ (instancetype) where:(NSString *)field like:(id)value;
+ (instancetype) where:(NSString *)field lowerOrEqualTo:(id)value;
+ (instancetype) where:(NSString *)field lowerThan:(id)value;

@end