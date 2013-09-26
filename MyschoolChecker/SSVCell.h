//
//  SSVCell.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 22.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *completedImage;


@end
