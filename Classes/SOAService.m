//
//  SOAService.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAService.h"
#import <AFNetworking/AFNetworking.h>
#import "SOAManager.h"

static NSOperationQueue *_serviceQueue;

@implementation SOAService

+ (NSOperationQueue *) serviceQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceQueue = [[NSOperationQueue alloc] init];
        _serviceQueue.name = @"com.coderockr.soa.service.queue";
    });
    return _serviceQueue;
}

- (void) executeRequest:(NSURLRequest *)request
        completionBlock:(SOACompletionBlock)completion
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion != NULL) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completion(responseObject, nil);
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion != NULL) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completion(nil, error);
            }];
        }
    }];
    
    [[SOAService serviceQueue] addOperation:operation];
}

- (NSURLRequest *) buildRequest:(NSString *)method
                            url:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                        headers:(NSDictionary *)headers
                          error:(NSError **)error
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method
                                                                                 URLString:urlString
                                                                                parameters:parameters
                                                                                     error:error];
    
    NSMutableDictionary *requestHeaders = [[[SOAManager defaultManager] defaultHeaders] mutableCopy];
    if (headers) {
        [requestHeaders addEntriesFromDictionary:headers];
    }
    
    if (request) {
        request.allHTTPHeaderFields = requestHeaders;
    }
    
    return request;
}

#pragma mark - REST
- (void) get:(NSURL *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
  completion:(SOACompletionBlock)completion
{
    NSMutableDictionary *headersDictionary = [@{} mutableCopy];
    NSDictionary *defaultHeaders = [[SOAManager defaultManager] defaultHeadersForMethod:SOAServiceMethodGET];
    [headersDictionary addEntriesFromDictionary:defaultHeaders];
    
    if (headers != nil) {
        [headersDictionary addEntriesFromDictionary:headers];
    }
    
    NSError *error;
    NSURLRequest *request = [self buildRequest:@"GET"
                                           url:url.absoluteString
                                    parameters:parameters
                                       headers:headersDictionary
                                         error:&error];
    
    if (!request) {
        if (completion != NULL) {
            completion(nil, error);
        }
        return;
    }
    
    [self executeRequest:request
         completionBlock:completion];
}

- (void) post:(NSURL *)url
   parameters:(NSDictionary *)parameters
      headers:(NSDictionary *)headers
   completion:(SOACompletionBlock)completion
{
    NSMutableDictionary *headersDictionary = [@{} mutableCopy];
    NSDictionary *defaultHeaders = [[SOAManager defaultManager] defaultHeadersForMethod:SOAServiceMethodPOST];
    [headersDictionary addEntriesFromDictionary:defaultHeaders];
    
    if (headers != nil) {
        [headersDictionary addEntriesFromDictionary:headers];
    }
    
    NSError *error;
    NSURLRequest *request = [self buildRequest:@"POST"
                                           url:url.absoluteString
                                    parameters:parameters
                                       headers:headersDictionary
                                         error:&error];
    
    if (!request) {
        if (completion) {
            completion(nil, error);
        }
        return;
    }
    
    [self executeRequest:request
         completionBlock:completion];
}

- (void) put:(NSURL *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
  completion:(SOACompletionBlock)completion
{
    NSMutableDictionary *headersDictionary = [@{} mutableCopy];
    NSDictionary *defaultHeaders = [[SOAManager defaultManager] defaultHeadersForMethod:SOAServiceMethodPUT];
    [headersDictionary addEntriesFromDictionary:defaultHeaders];
    
    if (headers != nil) {
        [headersDictionary addEntriesFromDictionary:headers];
    }

    NSError *error;
    NSURLRequest *request = [self buildRequest:@"PUT"
                                           url:url.absoluteString
                                    parameters:parameters
                                       headers:headersDictionary
                                         error:&error];
    
    if (!request) {
        if (completion != NULL) {
            completion(nil, error);
        }
        return;
    }
    
    [self executeRequest:request
         completionBlock:completion];
}

- (void) delete:(NSURL *)url
        headers:(NSDictionary *)headers
     completion:(SOACompletionBlock)completion
{
    NSMutableDictionary *headersDictionary = [@{} mutableCopy];
    NSDictionary *defaultHeaders = [[SOAManager defaultManager] defaultHeadersForMethod:SOAServiceMethodDELETE];
    [headersDictionary addEntriesFromDictionary:defaultHeaders];
    
    if (headers != nil) {
        [headersDictionary addEntriesFromDictionary:headers];
    }
    
    NSError *error;
    NSURLRequest *request = [self buildRequest:@"DELETE"
                                           url:url.absoluteString
                                    parameters:nil
                                       headers:headersDictionary
                                         error:&error];
    
    if (!request) {
        if (completion != NULL) {
            completion(nil, error);
        }
        return;
    }
    
    [self executeRequest:request
         completionBlock:completion];
}

@end