//
//  SOATypes.h
//  SOA
//
//  Created by André Gustavo Espeiorin on 10/17/14.
//  Copyright (c) 2014 Andre Gustavo. All rights reserved.
//

#ifndef SOA_SOATypes_h
#define SOA_SOATypes_h

typedef void(^SOACompletionBlock)(id result, NSError *error);

typedef enum : NSUInteger {
    SOAServiceMethodGET,
    SOAServiceMethodPOST,
    SOAServiceMethodPUT,
    SOAServiceMethodDELETE,
    SOAServiceMethodALL
} SOAServiceMethod;

#endif