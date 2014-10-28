//
//  SOAManager.m
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#import "SOAManager.h"
#import "SOAService.h"
#import <UIKit/UIApplication.h>

static SOAManager *_defaultManager;
static dispatch_once_t onceToken;

@interface SOAManager ()

@property (nonatomic, strong, readonly) NSMutableDictionary *headers;

- (void) startMonitoringServiceQueue;
- (void) stopMonitoringServiceQueue;

@end

@implementation SOAManager

@synthesize headers = _headers;

#pragma mark - Instance Control
+ (instancetype) defaultManager
{
    dispatch_once(&onceToken, ^{
        _defaultManager = [[SOAManager alloc] init];
    });

    return _defaultManager;
}

#pragma mark - Setters
- (void) setMaxConcurrentRequests:(NSUInteger)maxConcurrentRequests
{
    _maxConcurrentRequests = maxConcurrentRequests;
    [SOAService serviceQueue].maxConcurrentOperationCount = _maxConcurrentRequests;
}

- (void) setControlNetworkActivity:(BOOL)controlNetworkActivity
{
    _controlNetworkActivity = controlNetworkActivity;
    if (_controlNetworkActivity) {
        [self startMonitoringServiceQueue];
    } else {
        [self stopMonitoringServiceQueue];
    }
}

#pragma mark - Instance Methods
- (void) startMonitoringServiceQueue
{
    [[SOAService serviceQueue] addObserver:self
                                forKeyPath:@"operationCount"
                                   options:NSKeyValueObservingOptionNew
                                   context:nil];
}

- (void) stopMonitoringServiceQueue
{
    [[SOAService serviceQueue] removeObserver:self
                                   forKeyPath:@"operationCount"];
}

#pragma mark - KVO
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    if ([object isEqual:[SOAService serviceQueue]] &&
        [keyPath isEqualToString:@"operationCount"]) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = [SOAService serviceQueue].operationCount > 0;
        
    }
}

#pragma mark - Headers Management
- (NSMutableDictionary *) headers
{
    if (_headers != nil) {
        return _headers;
    }
    
    _headers = [NSMutableDictionary dictionary];
    return _headers;
}

- (void) setDefaultHeaders:(NSDictionary *)headers
{
    self.headers[@(SOAServiceMethodALL)] = headers;
}

- (void) setDefaultHeaders:(NSDictionary *)headers forMethod:(SOAServiceMethod)method
{
    self.headers[@(method)] = headers;
}

- (NSDictionary *) defaultHeaders
{
    NSDictionary *headers = self.headers[@(SOAServiceMethodALL)];
    return headers ?: @{};
}

- (NSDictionary *) defaultHeadersForMethod:(SOAServiceMethod)method
{
    NSDictionary *headers = self.headers[@(method)];
    return headers ?: @{};
}

@end