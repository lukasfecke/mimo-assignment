//
//  MASignUpViewController.m
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import "MASignUpViewController.h"

@interface MASignUpViewController ()

@end

@implementation MASignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)signUp:(id)sender
{
    [super signupWithCompletion:^(NSDictionary *dictionary, NSError *error)
     {
         if (error || [dictionary valueForKey:@"email"] == nil)
         {
             NSString *message = @"Something went wrong.";
             if ([dictionary valueForKey:@"error_description"] != nil)
             {
                 message = [dictionary valueForKey:@"error_description"];
             }
             else if ([dictionary valueForKey:@"description"])
             {
                 message = [dictionary valueForKey:@"description"];
             }
             else if ([dictionary valueForKey:@"error"])
             {
                 message = [dictionary valueForKey:@"error"];
             }

             [super showPopUpWithTitle:@"Error" andWithMessage:message];
         }
         else
         {
             //at least will redirect to the Account screen, because login deosnt work
             [self performSegueWithIdentifier:@"MASignUpSegue" sender:self];
//             [super loginWithCompletion:^(NSDictionary *dictionary, NSError *error)
//             {
//                 if (error || [dictionary valueForKey:@"access_token"] == nil)
//                 {
//                     NSString *message = @"Something went wrong.";
//                     if ([dictionary valueForKey:@"error_description"] != nil)
//                     {
//                         message = [dictionary valueForKey:@"error_description"];
//                     }
//                     else if ([dictionary valueForKey:@"description"])
//                     {
//                         message = [dictionary valueForKey:@"description"];
//                     }
//                     else if ([dictionary valueForKey:@"error"])
//                     {
//                         message = [dictionary valueForKey:@"error"];
//                     }
//                     
//                     [super showPopUpWithTitle:@"Error" andWithMessage:message];
//                 }
//                 else
//                 {
//                     [self performSegueWithIdentifier:@"MASignUpSegue" sender:self];
//                 }
//             }];
         }
     }];
}

@end
