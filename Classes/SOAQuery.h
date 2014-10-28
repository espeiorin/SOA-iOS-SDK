//
//  SOAQuery.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAService.h"

@class SOAFilter;
@class SOAJoin;

@interface SOAQuery : SOAService

@property (nonatomic, strong, readonly) NSString *entityName;
@property (nonatomic, strong, readonly) NSMutableArray *filters;
@property (nonatomic, strong, readonly) NSMutableArray *joins;
@property (nonatomic, strong) NSArray *fields;
@property (nonatomic) NSUInteger limit;
@property (nonatomic) NSUInteger offset;

- (instancetype) initWithEntityName:(NSString *) entityName;

- (void) addFilter:(SOAFilter *)filter;
- (void) removeFilter:(SOAFilter *)filter;
- (void) clearFilters;

- (void) addJoin:(SOAJoin *)join;
- (void) removeJoin:(SOAJoin *)join;
- (void) clearJoins;

- (void) performQueryWithCompletionBlock:(SOACompletionBlock)completion;

@end