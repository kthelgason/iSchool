//
//  SSVMenuViewController.m
//  MyschoolChecker
//
//  Created by Björn Orri Sæmundsson on 05/11/13.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVMenuViewController.h"
#import "SSVMyschoolChecker.h"
#import "TFHpple.h"

@interface SSVMenuViewController ()

@property (weak, nonatomic) IBOutlet UITextView *menuView;

@end

@implementation SSVMenuViewController

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
	// Do any additional setup after loading the view.
    
    NSArray* menu = [SSVMyschoolChecker fetchMowl];
    
    NSMutableString* menuText = [NSMutableString stringWithString:@""];
    
    for(TFHppleElement* element in menu)
    {
        if(![element text])
        {
            [menuText appendString:@"\n"];
        }
        else if([[element text] length] > 1)
        {
            [menuText appendString:[NSString stringWithFormat:@"%@\n", [element text]]];
        }
    }
    
    self.menuView.text = menuText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
