//
//  SOAService.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOATypes.h"

extern NSString *SOAServiceAuthErrorNotification;

@interface SOAService : NSObject

+ (NSOperationQueue *) serviceQueue;

- (void) executeRequest:(NSURLRequest *)request
        completionBlock:(SOACompletionBlock)completion;

- (void) get:(NSURL *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
  completion:(SOACompletionBlock)completion;

- (void) post:(NSURL *)url
   parameters:(NSDictionary *)parameters
      headers:(NSDictionary *)headers
   completion:(SOACompletionBlock)completion;

- (void) put:(NSURL *)url
   parameters:(NSDictionary *)parameters
      headers:(NSDictionary *)headers
   completion:(SOACompletionBlock)completion;

- (void) delete:(NSURL *)url
        headers:(NSDictionary *)headers
     completion:(SOACompletionBlock)completion;

@end