//
//  MAViewController.h
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAViewController : UIViewController


@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *access_token;

- (void)loginWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;;
- (void)signupWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
- (void)logoutWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
- (void)showPopUpWithTitle:(NSString*)title andWithMessage:(NSString*)message;

@end
