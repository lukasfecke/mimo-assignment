//
//  MAAccountViewController.m
//  Mimo Assignment
//
//  Created by Lukáš Fečke on 31/01/2017.
//  Copyright © 2017 Lukáš Fečke. All rights reserved.
//

#import "MAAccountViewController.h"

@interface MAAccountViewController ()

@property (nonatomic,weak) IBOutlet UILabel *emailLabel;

@end

@implementation MAAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *email = [super email];
    [self.emailLabel setText:email];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
