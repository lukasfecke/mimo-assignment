//
//  MAServerManager.h
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAServerManager : NSObject

//properties
@property (nonatomic,strong) NSString *access_token;
@property (nonatomic,strong) NSString *email;

//methods
+ (id)serverManager;
- (void)authenticateSignUpWithEmail:(NSString*)email andWithPassword:(NSString*)password andWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
- (void)authenticateLoginWithEmail:(NSString*)email andWithPassword:(NSString*)password andWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;

@end
