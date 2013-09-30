//
//  SSVLoginViewController.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 26.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSVLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *loginNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

- (IBAction)submit:(id)sender;

@end
