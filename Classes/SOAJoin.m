//
//  SOAJoin.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAJoin.h"
#import "SOAFilter.h"

@interface SOAJoin ()

- (instancetype) initWithFieldName:(NSString *)fieldName filter:(SOAFilter *)filter;

@end

@implementation SOAJoin

@synthesize fieldName = _fieldName;
@synthesize filter = _filter;

- (instancetype) initWithFieldName:(NSString *)fieldName filter:(SOAFilter *)filter
{
    self = [super init];
    
    NSAssert(fieldName != nil, @"Relation field is mandatory!!");
    NSAssert(filter != nil, @"You must provide a valid filter object!!");
    
    if (self) {
        _fieldName = fieldName;
        _filter = filter;
    }
    
    return self;
}

+ (instancetype) joinField:(NSString *)fieldName withFilter:(SOAFilter *)filter
{
    return [[SOAJoin alloc] initWithFieldName:fieldName filter:filter];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@:%@", self.fieldName, self.filter];
}

@end