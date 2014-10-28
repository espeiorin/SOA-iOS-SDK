//
//  SOARPCCall.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOARPCCall.h"
#import "SOAManager.h"

#import <AFNetworking/AFNetworking.h>

@implementation SOARPCCall

- (void) callProcedure:(NSString *)procedure
            parameters:(NSDictionary *)parameters
               headers:(NSDictionary *)headers
       completionBlock:(SOACompletionBlock)completion
{
    NSURL *rpcURL = [SOAManager defaultManager].rpcURL;
    rpcURL = [rpcURL URLByAppendingPathComponent:procedure];
    
    if (parameters != nil) {
        parameters = @{@"parameters" : parameters};
    }
    
    [super post:rpcURL
     parameters:parameters
        headers:headers
     completion:completion];
}

@end