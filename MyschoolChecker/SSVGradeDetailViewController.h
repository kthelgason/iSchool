//
//  SSVGradeDetailViewController.h
//  MyschoolChecker
//
//  Created by Björn Orri Sæmundsson on 10/21/13.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSVGrade.h"

@interface SSVGradeDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (strong, nonatomic) SSVGrade* grade;

@end
