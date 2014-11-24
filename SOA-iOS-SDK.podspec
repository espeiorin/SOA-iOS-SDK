#
#  Be sure to run `pod spec lint SOA-iOS-SDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SOA-iOS-SDK"
  s.version      = "0.1.1"
  s.summary      = "SOA-iOS-SDK is a client built to consume SOA Server based APIs."

  s.description  = <<-DESC
                   [SOA Server](https://github.com/coderockr/soa) is a great way to build your Web Services, it's built on top of Silex and Doctrine 2, but using iOS as a client you couldn't get the same experience, until now. After a long time using SOA Server I decided to transport the same mindset to Objective-C and the result is this library.

                    ##Getting SOA iOS SDK

                    ###Cocoapods

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
                   DESC

  s.homepage     = "https://github.com/espeiorin/SOA-iOS-SDK"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "André Gustavo Espeiorin" => "andre.espeiorin@gmail.com" }
  s.social_media_url   = "http://twitter.com/espeiorin"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios
  s.platform     = :ios, "7.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/espeiorin/SOA-iOS-SDK.git", :tag => "0.1.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/**/*.h"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  s.framework  = "UIKit"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true
  s.dependency "AFNetworking", "~> 2.0"

end
