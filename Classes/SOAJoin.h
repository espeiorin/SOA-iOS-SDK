//
//  SOAJoin.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOAFilter;

@interface SOAJoin : NSObject

@property (nonatomic, strong, readonly) NSString *fieldName;
@property (nonatomic, strong, readonly) SOAFilter *filter;

+ (instancetype) joinField:(NSString *)fieldName withFilter:(SOAFilter *)filter;

@end