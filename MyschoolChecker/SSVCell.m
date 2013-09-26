//
//  SSVCell.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 22.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVCell.h"

@implementation SSVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
