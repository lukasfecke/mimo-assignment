//
//  MALoginViewController.m
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import "MALoginViewController.h"

@interface MALoginViewController ()


@end

@implementation MALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logIn:(id)sender
{
    [super loginWithCompletion:^(NSDictionary *dictionary, NSError *error)
    {
        if (error || [dictionary valueForKey:@"access_token"] == nil)
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
            [self performSegueWithIdentifier:@"MALoginSegue" sender:self];
        }
    }];
}

@end
