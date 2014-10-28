//
//  SOARPCCall.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAService.h"

@interface SOARPCCall : SOAService

- (void) callProcedure:(NSString *)procedure
            parameters:(NSDictionary *)parameters
               headers:(NSDictionary *)headers
       completionBlock:(SOACompletionBlock)completion;

@end
