//
//  SSVLoginViewController.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 26.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVLoginViewController.h"
#import "SSVUser.h"

@interface SSVLoginViewController ()

@end

@implementation SSVLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    SSVUser* user = [SSVUser user];
    user.loginName = [[self loginNameField] text];
    user.password = [[self passwordField] text];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

}
@end
