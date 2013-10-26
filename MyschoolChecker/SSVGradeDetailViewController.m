//
//  SSVGradeDetailViewController.m
//  MyschoolChecker
//
//  Created by Björn Orri Sæmundsson on 10/21/13.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVGradeDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SSVGradeDetailViewController ()

@end

@implementation SSVGradeDetailViewController

@synthesize courseLabel, gradeLabel, rankLabel, commentView;

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
    self.courseLabel.text = [[self grade] getCourse];
    self.gradeLabel.text =[[self grade] getGrade];
    self.rankLabel.text = [[self grade] getRank];
    self.commentView.text = [[self grade] feedback];
    self.navigationItem.title = [[self grade] assignmentName];
    self.commentView.layer.borderWidth = 1.0f;
    self.commentView.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
