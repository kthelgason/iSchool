//
//  SSVGradeCell.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 11.10.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSVGradeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *assignmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@end
