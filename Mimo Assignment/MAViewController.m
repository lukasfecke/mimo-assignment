//
//  MAViewController.m
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import "MAViewController.h"
#import "MAServerManager.h"

@interface MAViewController ()

@property (nonatomic,weak) IBOutlet UITextField *emailTextField;
@property (nonatomic,weak) IBOutlet UITextField *passwordTextField;

@end

@implementation MAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MAServerManager serverManager];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardForAllTextFieldsInView)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self clearFields];
    [super viewWillAppear:animated];
    
}

- (NSString*)email
{
    return [[MAServerManager serverManager] email];
}

- (NSString*)access_token
{
    return [[MAServerManager serverManager] access_token];
}

- (void)clearFields
{
    for (UITextField *textField in [self.view subviews])
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            [textField setText:@""];
        }
    }
    
    [self dismissKeyboardForAllTextFieldsInView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)popViewToLogin:(id)sender
{
    [self logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loginWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
{
    [self dismissKeyboardForAllTextFieldsInView];
    
    [[MAServerManager serverManager] authenticateLoginWithEmail:[self.emailTextField text] andWithPassword:[self.passwordTextField text] andWithCompletion:completion];
}

- (void)signupWithCompletion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
{
    [[MAServerManager serverManager] authenticateSignUpWithEmail:[self.emailTextField text] andWithPassword:[self.passwordTextField text] andWithCompletion:completion];
}

- (bool)logout
{
    return NO;
}

-(void)dismissKeyboardForAllTextFieldsInView
{
    for (UITextField *textField in [self.view subviews])
    {
        [textField resignFirstResponder];
    }
}

- (void)showPopUpWithTitle:(NSString*)title andWithMessage:(NSString*)message
{
    UIAlertController *popUpController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [popUpController addAction:okAction];
    
    [self presentViewController:popUpController animated:YES completion:nil];
}

@end
