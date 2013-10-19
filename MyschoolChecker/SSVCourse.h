//
//  SSVCourse.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 11.10.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSVGrade;

@interface SSVCourse : NSObject

@property(nonatomic, strong)NSMutableArray* grades;
@property(nonatomic, strong)NSString* courseName;


@end
