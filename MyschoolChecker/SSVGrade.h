//
//  SSVGrade.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 9.10.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSVGrade : NSObject

@property(nonatomic, copy)NSString* assignmentName;
@property(nonatomic, copy)NSString* grade;
@property(nonatomic, copy)NSString* order;
@property(nonatomic, copy)NSString* feedback;
@property(nonatomic, copy)NSString* inCourse;

-(NSString*)getCourse;
-(NSString*)getRank;
-(NSString*)getGrade;

@end
