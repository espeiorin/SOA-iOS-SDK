//
//  SOAObject.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOAService.h"

@interface SOAObject : SOAService

@property (nonatomic) NSUInteger entityId;
@property (nonatomic, strong) NSString *entityName;
@property (nonatomic, strong, readonly) NSMutableDictionary *values;

- (instancetype) initWithEntityName:(NSString *)entityName;
- (instancetype) initWithEntityName:(NSString *)entityName
                           entityId:(NSUInteger)entityId;

+ (void) getWithEntityName:(NSString *)entityName
                  entityId:(NSUInteger)entityId
           completionBlock:(SOACompletionBlock)completion;

+ (void) saveEntity:(NSString *)entityName
         parameters:(NSDictionary *)parameters
    completionBlock:(SOACompletionBlock)completion;

+ (void) deleteEntity:(NSString *)entityName
             entityId:(NSUInteger)entityId
      completionBlock:(SOACompletionBlock)completion;

- (void) saveWithCompletionBlock:(SOACompletionBlock)completion;
- (void) deleteWithCompletionBlock:(SOACompletionBlock)completion;

- (void) readValuesFromDictionary:(NSDictionary *)dictionary;

@end