//
//  SSVMyschoolChecker.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 21.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSVMyschoolChecker : NSObject

+ (NSArray*)fetchAssignments;
+ (NSArray*)fetchGrades;

+ (BOOL)checkAuthstring:(NSString*)authString;


@end
