//
//  SOAManager.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOATypes.h"

@interface SOAManager : NSObject

@property (nonatomic, strong) NSURL *apiURL;
@property (nonatomic, strong) NSURL *rpcURL;
@property (nonatomic) NSUInteger maxConcurrentRequests;
@property (nonatomic, getter=shouldControlNetworkActivity) BOOL controlNetworkActivity;

+ (instancetype) defaultManager;

- (void) setDefaultHeaders:(NSDictionary *)headers;
- (void) setDefaultHeaders:(NSDictionary *)headers forMethod:(SOAServiceMethod)method;

- (NSDictionary *) defaultHeaders;
- (NSDictionary *) defaultHeadersForMethod:(SOAServiceMethod)method;

@end