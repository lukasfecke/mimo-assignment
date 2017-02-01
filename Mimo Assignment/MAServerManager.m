//
//  MAServerManager.m
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import "MAServerManager.h"

@implementation MAServerManager

+ (id)serverManager
{
    static MAServerManager *serverManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        serverManager = [[self alloc] init];
    });
    
    return serverManager;
}

- (id)init {
    if (self = [super init])
    {
        self.email = @"";
        self.access_token = @"";
    }
    //maybe problem in authentication?
//    [self authorizeApp];
    return self;
}

- (void)authenticateSignUpWithEmail:(NSString*)email andWithPassword:(NSString*)password andWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion
{
    NSString *requestStringUrl = @"https://mimo-test.auth0.com/dbconnections/signup";
    NSString *client_id = @"PAn11swGbMAVXVDbSCpnITx5Utsxz1co";
    NSString *connection_name = @"Username-Password-Authentication";
    
    NSString *dataString = [NSString stringWithFormat:@"client_id=%@&email=%@&password=%@&connection=%@", client_id, email, password, connection_name];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:requestStringUrl]];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Create request task
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary *jsonDictionary = [self getJsonFromDataOrReturnError:data];
        self.email = [jsonDictionary valueForKey:@"email"];
        completion(jsonDictionary, error);
    }];
    
    [dataTask resume];
}

- (void)authenticateLoginWithEmail:(NSString*)email andWithPassword:(NSString*)password andWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion
{
    NSString *requestStringUrl = @"https://mimo-test.auth0.com/oauth/token";
    NSString *grant_type = @"password";
    NSString *client_id = @"PAn11swGbMAVXVDbSCpnITx5Utsxz1co";
    
    NSString *dataString = [NSString stringWithFormat:@"grant_type=%@&client_id=%@&username=%@&password=%@", grant_type, client_id, email, password];//client_secret, email, password];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:requestStringUrl]];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Create request task
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary *jsonDictionary = [self getJsonFromDataOrReturnError:data];
        self.access_token = [jsonDictionary valueForKey:@"access_token"];
        completion(jsonDictionary, error);
    }];
    
    [dataTask resume];
}

- (void)authorizeApp
{
    NSString *requestStringUrl = @"https://mimo-test.auth0.com/authorize?";
    NSString *response_type = @"code";
    NSString *client_id = @"PAn11swGbMAVXVDbSCpnITx5Utsxz1co";
    
    NSString *dataString = [NSString stringWithFormat:@"response_type=%@&client_id=%@", response_type, client_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:requestStringUrl]];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Create request task
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSLog(@"AUTHORIZATION GET request returned!");
                                      }];
    
    [dataTask resume];
}

- (NSDictionary *)getJsonFromDataOrReturnError:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *jsonArray;
    if (data)
    {
        jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error != nil) {
            NSLog(@"Error parsing JSON.");
        }
        else {
            NSLog(@"Array: %@", jsonArray);
        }
    }
    
    return jsonArray;
}



@end
