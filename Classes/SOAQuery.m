//
//  SOAQuery.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAQuery.h"
#import "SOAManager.h"
#import "SOAObject.h"
#import <AFNetworking/AFNetworking.h>

@implementation SOAQuery

@synthesize entityName = _entityName;
@synthesize filters = _filters;
@synthesize joins = _joins;

- (instancetype) initWithEntityName:(NSString *) entityName
{
    NSAssert(entityName != nil && entityName.length > 0, @"You must provide a valid entity name");
    
    self = [super init];
    
    if (self) {
        _entityName = entityName;
        _offset = NSNotFound;
        _limit = NSNotFound;
    }
    
    return self;
}

#pragma mark - Getters
- (NSMutableArray *) filters
{
    if (_filters != nil) {
        return _filters;
    }
    
    _filters = [NSMutableArray array];
    
    return _filters;
}

- (NSMutableArray *) joins
{
    if (_joins != nil) {
        return _joins;
    }
    
    _joins = [NSMutableArray array];
    
    return _joins;
}

#pragma mark - Filters
- (void) addFilter:(SOAFilter *)filter
{
    NSAssert(filter != nil, @"You must provide a valid filter");
    [self.filters addObject:filter];
}

- (void) removeFilter:(SOAFilter *)filter
{
    if ([self.filters containsObject:filter]) {
        [self.filters removeObject:filter];
    }
}

- (void) clearFilters
{
    [self.filters removeAllObjects];
}

#pragma mark - Joins
- (void) addJoin:(SOAJoin *)join
{
    NSAssert(join != nil, @"You must provide a valid join");
    [self.joins addObject:join];
}

- (void) removeJoin:(SOAJoin *)join
{
    if ([self.joins containsObject:join]) {
        [self.joins removeObject:join];
    }
}

- (void) clearJoins
{
    [self.joins removeAllObjects];
}

#pragma mark -
- (void) performQueryWithCompletionBlock:(SOACompletionBlock)completion
{
    NSURL *apiURL = [SOAManager defaultManager].apiURL;
    apiURL = [apiURL URLByAppendingPathComponent:self.entityName];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.offset != NSNotFound) {
        params[@"offset"] = @(self.offset);
    }
    
    if (self.limit != NSNotFound) {
        params[@"limit"] = @(self.limit);
    }
    
    if (_fields && self.fields.count > 0) {
        params[@"fields"] = [self.fields componentsJoinedByString:@","];
    }
    
    if (_filters && self.filters.count > 0) {
        params[@"filter"] = [self.filters componentsJoinedByString:@","];
    }
    
    if (_joins && self.joins.count > 0) {
        params[@"join"] = [self.joins componentsJoinedByString:@","];
    }
    
    [super get:apiURL
    parameters:params
       headers:nil
    completion:^(id result, NSError *error) {
        NSMutableArray *queryResult = [NSMutableArray array];
        if (result && [result count] > 0) {
            for (NSDictionary *objectData in result) {
                @autoreleasepool {
                    if ([objectData.allKeys containsObject:@"id"]) {
                        SOAObject *object = [[SOAObject alloc] initWithEntityName:self.entityName
                                                                         entityId:[objectData[@"id"] integerValue]];
                        [object readValuesFromDictionary:objectData];
                        [queryResult addObject:object];
                    }
                }
            }
        }
        
        if (completion != NULL) {
            completion(queryResult, error);
        }
    }];
}

@end