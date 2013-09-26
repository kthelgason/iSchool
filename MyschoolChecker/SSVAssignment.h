//
//  SSVAssignment.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSVAssignment : NSObject

@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* courseName;
@property(nonatomic, copy)NSString* courseId;
@property(nonatomic, copy)NSString* handedIn;
@property(nonatomic, copy)NSString* dueDate;
@property(nonatomic, copy)NSString* assignmentURL;

// Images
@property(nonatomic, weak)UIImage* notDoneImage;
@property(nonatomic, weak)UIImage* doneImage;

@end
