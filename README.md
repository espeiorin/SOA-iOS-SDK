SOA-iOS-SDK
===========

[![Licence](http://img.shields.io/cocoapods/l/SOA-iOS-SDK.svg?style=flat-square)](http://cocoadocs.org/docsets/SOA-iOS-SDK)
[![Plafform](http://img.shields.io/cocoapods/p/SOA-iOS-SDK.svg?style=flat-square)](http://cocoadocs.org/docsets/SOA-iOS-SDK)
[![Plafform](http://img.shields.io/cocoapods/v/SOA-iOS-SDK.svg?style=flat-square)](http://cocoadocs.org/docsets/SOA-iOS-SDK)

[SOA Server](https://github.com/coderockr/soa) is a great way to build your Web Services, it's built on top of Silex and Doctrine 2, but using iOS as a client you couldn't get the same experience, until now. After using SOA Server for a long time I decided to use the same mindset with Objective-C and the result is this library.

##Getting SOA iOS SDK

###Cocoapods
```objc
pod 'SOA-iOS-SDK', '~> 0.1.0'
```

##Configure it
In order to get SOA SDK working, you must configure the API URL and shared headers.
* apiURL for the REST Calls
* rpcURL for the RPC Calls

```objc
[SOAManager defaultManager].apiURL = [NSURL URLWithString:@"http://serveraddress.com/api/v1"];

[SOAManager defaultManager].rpcURL = [NSURL URLWithString:@"http://serveraddress.com/rpc/v1"];

[[SOAManager defaultManager] setDefaultHeaders:@{@"Authorization" : @"_authorization_token_"}];
```

Including shared headers for each HTTP Method available at REST API.
```objc
SOAServiceMethodGET,
SOAServiceMethodPOST,
SOAServiceMethodPUT,
SOAServiceMethodDELETE,
SOAServiceMethodALL

[[SOAManager defaultManager] setDefaultHeaders:@{@"Content-Type" : @"application/x-www-form-urlencoded"} forMethod:SOAServiceMethodPOST];

[[SOAManager defaultManager] setDefaultHeaders:@{@"Content-Type" : @"application/x-www-form-urlencoded"} forMethod:SOAServiceMethodPUT];
```

###Miscelaneous
Right now, you can configure the queue concurrent requests limits and you can also delegate to SOA SDK the responsability to display or hide the Network Activity Status.
```objc
[SOAManager defaultManager].maxConcurrentRequests = 4;
[SOAManager defaultManager].controlNetworkActivity = YES;
```

##The SOA Object

SOAObject is a NSObject subclass built to storage entity's data. SOAObject has only one mandatory property, which is Entity Name, but you can set the entity id. Both properties are intended to identify the object. 

Beyond it, you can store any kind of data (pointers) using setValue:forKey: and you can also retrieve any data using valueForKey: method.


###Creating New

```objc
SOAObject *hotel = [[SOAObject alloc] initWithEntityName:@"hotel"];

SOAObject *knownHotel = [[SOAObject alloc] initWithEntityName:@"hotel" entityId:12];
```
###Dealing with data
```objc
[hotel setValue:@"Ibis" forKey:@"name"];
[hotel setValue:@"R. Nove de Março" forKey:@"street"];

NSString *name = [hotel valueForKey:@"name"];
```

###Fetching an Object
```objc
[SOAObject getWithEntityName:@"hotel"
                    entityId:12
             completionBlock:^(id result, NSError *error) {
                 SOAObject *object = (SOAObject *)result;
             }];
```

###Saving an Object
#####Static Way
```objc
[SOAObject saveEntity:@"hotel"
           parameters:@{
                        @"id" : @(10),
                        @"name" : @"Bourbon",
                        @"street" : @"R. Visconde de Taunay"
                        }
      completionBlock:^(id result, NSError *error) {
          
      }];
```
#####Instance Way
```objc
[hotel saveWithCompletionBlock:^(id result, NSError *error) {
    
}];
```
###Deleting an Object
#####Static Way
```objc
[SOAObject getWithEntityName:@"hotel"
                    entityId:12
             completionBlock:^(id result, NSError *error) {
                 SOAObject *object = (SOAObject *)result;
             }];
```
#####Instance Way
```objc
[hotel deleteWithCompletionBlock:^(id result, NSError *error) {
    
}];
```
##The SOA Query
###Building a query
```objc
SOAQuery *query = [[SOAQuery alloc] initWithEntityName:@"hotel"];
query.offset = 0;
query.limit = 100;
query.fields = @[@"name", @"id"];
```

###SOA Filter
```objc
SOAFilter *filter = [SOAFilter where:@"id" equalTo:@26];
[query addFilter:filter];
```
###SOA Join
```objc
SOAFilter *joinFilter = [SOAFilter where:@"id" equalTo:@10];
SOAJoin *join = [SOAJoin joinField:@"user" withFilter:joinFilter];
[query addJoin:join];
```

###Perform Query
```objc
[query performQueryWithCompletionBlock:^(id result, NSError *error) {
    NSLog(@"%@", result);
}];
```

##The SOA RPC Call

```objc
SOARPCCall *rpc = [[SOARPCCall alloc] init];
[rpc callProcedure:@"/authentication/login"
        parameters:@{@"email" : @"user@email.com", @"password" : @"passwd"}
           headers:nil
   completionBlock:^(id result, NSError *error) {
       NSLog(@"%@", result);
       NSLog(@"%@", error);
   }];
```
