//
//  SOAFilter.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAFilter.h"

static NSString const *kSOAFilterEqualTo = @"eq";
static NSString const *kSOAFilterLike = @"like";
static NSString const *kSOAFilterLowerThan = @"lt";
static NSString const *kSOAFilterLowerOrEqualTo = @"lte";
static NSString const *kSOAFilterGreaterThan = @"gt";
static NSString const *kSOAFilterGreaterOrEqualTo = @"gte";
static NSString const *kSOAFilterNotEqualTo = @"neq";

@interface SOAFilter ()

- (instancetype) initWithField:(NSString *)field
                     condition:(const NSString *)condition
                         value:(id)value;

@end

@implementation SOAFilter

@synthesize field = _field;
@synthesize condition = _condition;
@synthesize value = _value;

- (instancetype) initWithField:(NSString *)field
                     condition:(NSString *)condition
                         value:(id)value
{
    NSAssert(field != nil, @"You must provide a valid field name!");
    NSAssert(condition != nil, @"You must provide a valid condition!");
    NSAssert(value != nil, @"You must provide a valid value!");
    
    self = [super init];
    
    if (self) {
        _field = field;
        _condition = condition;
        _value = value;
    }
    
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@:%@:%@", self.field, self.condition, self.value];
}

+ (instancetype) buildFilter:(NSString *)field
                   condition:(const NSString *)condition
                       value:(id)value
{
    SOAFilter *filter = [[SOAFilter alloc] initWithField:field
                                               condition:condition
                                                   value:value];
    return filter;
}

+ (instancetype) where:(NSString *)field notEqualTo:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterNotEqualTo value:value];
}

+ (instancetype) where:(NSString *)field equalTo:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterEqualTo value:value];
}

+ (instancetype) where:(NSString *)field greaterOrEqualTo:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterGreaterOrEqualTo value:value];
}

+ (instancetype) where:(NSString *)field greaterThan:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterGreaterThan value:value];
}

+ (instancetype) where:(NSString *)field like:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterLike value:value];
}

+ (instancetype) where:(NSString *)field lowerOrEqualTo:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterLowerOrEqualTo value:value];
}

+ (instancetype) where:(NSString *)field lowerThan:(id)value
{
    return [SOAFilter buildFilter:field condition:kSOAFilterLowerThan value:value];
}

@end