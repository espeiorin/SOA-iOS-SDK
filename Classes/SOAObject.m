//
//  SOAObject.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAObject.h"
#import "SOAQuery.h"
#import "SOAFilter.h"
#import "SOAManager.h"

@interface SOAObject ()

@end

@implementation SOAObject

@synthesize values = _values;

#pragma mark - Init
- (instancetype) initWithEntityName:(NSString *)entityName
                           entityId:(NSUInteger)entityId
{
    self = [super init];
    
    NSAssert(entityName != nil && entityName.length > 0, @"You must provide a valid entity name!");
    
    if (self) {
        self.entityName = entityName;
        self.entityId = entityId;
    }
    
    return self;
}

- (instancetype) initWithEntityName:(NSString *)entityName
{
    return [self initWithEntityName:entityName entityId:0];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"[%@ - %lu - %@]", self.entityName, (unsigned long)self.entityId, self.values];
}

#pragma mark - Get Object using only Id
+ (void) getWithEntityName:(NSString *)entityName
                  entityId:(NSUInteger)entityId
           completionBlock:(SOACompletionBlock)completion
{
    SOAQuery *query = [[SOAQuery alloc] initWithEntityName:entityName];
    SOAFilter *filter = [SOAFilter where:@"id" equalTo:@(entityId)];
    [query addFilter:filter];
    [query performQueryWithCompletionBlock:^(id result, NSError *error) {
        if (result && [result count] > 0) {
            completion(result[0], nil);
            return;
        }
        completion(nil, error);
    }];
}

#pragma mark - Other REST implementations
+ (void) saveEntity:(NSString *)entityName
         parameters:(NSDictionary *)parameters
    completionBlock:(SOACompletionBlock)completion
{
    SOACompletionBlock block = ^(id result, NSError *error) {
        if (completion != NULL) {
            completion(result, error);
        }
    };
    
    NSURL *apiURL = [SOAManager defaultManager].apiURL;
    apiURL = [apiURL URLByAppendingPathComponent:entityName];
    
    NSUInteger entityId = 0;
    if ([parameters.allKeys containsObject:@"id"]) {
        entityId = [parameters[@"id"] integerValue];
    }
    
    SOAService *service = [[SOAService alloc] init];
    if (entityId == 0) {
        [service post:apiURL
           parameters:parameters
              headers:nil
           completion:block];
        return;
    }
    
    apiURL = [apiURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu", (unsigned long)entityId]];
    [service put:apiURL
      parameters:parameters
         headers:nil
      completion:block];
}

- (void) saveWithCompletionBlock:(SOACompletionBlock)completion
{
    NSMutableDictionary *parameters = [self.values copy];
    if (self.entityId > 0) {
        parameters[@"id"] = @(self.entityId);
    }
    
    [SOAObject saveEntity:self.entityName
               parameters:parameters
          completionBlock:completion];
}

+ (void) deleteEntity:(NSString *)entityName
             entityId:(NSUInteger)entityId
      completionBlock:(SOACompletionBlock)completion
{
    NSAssert(entityId != 0, @"Entity id is mandatory");
    
    NSURL *apiURL = [SOAManager defaultManager].apiURL;
    apiURL = [apiURL URLByAppendingPathComponent:entityName];
    apiURL = [apiURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu", (unsigned long)entityId]];
    
    SOAService *service = [[SOAService alloc] init];
    [service delete:apiURL
            headers:nil
         completion:completion];
}

- (void) deleteWithCompletionBlock:(SOACompletionBlock)completion
{
    NSAssert(self.entityId > 0, @"You can't delete an object that doesn't exist");
    [SOAObject deleteEntity:self.entityName
                   entityId:self.entityId
            completionBlock:completion];
}

#pragma mark - Values
- (NSMutableDictionary *) values
{
    if (_values != nil) {
        return _values;
    }
    
    _values = [NSMutableDictionary dictionary];
    
    return _values;
}

- (void) readValuesFromDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutable = [dictionary mutableCopy];
    if ([mutable.allKeys containsObject:@"id"]) {
        self.entityId = [mutable[@"id"] integerValue];
        [mutable removeObjectForKey:@"id"];
    }
    [self.values addEntriesFromDictionary:mutable];
}

- (id) valueForUndefinedKey:(NSString *)key
{
    return self.values[key];
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    self.values[key] = value;
}

@end