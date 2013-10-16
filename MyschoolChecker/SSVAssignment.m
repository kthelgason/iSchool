//
//  SSVAssignment.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVAssignment.h"

@implementation SSVAssignment

@synthesize title, courseName, courseId, handedIn, dueDate, assignmentURL;
@synthesize notDoneImage, doneImage;

-(id)init{
    self = [super init];
    if(self){
        [self setNotDoneImage:[UIImage imageNamed:@"Cross.png"]];
        [self setDoneImage:[UIImage imageNamed:@"greencheck.png"]];
    }
    return self;
}


@end