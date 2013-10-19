//
//  SSVDataStore.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSVAssignment;

@interface SSVDataStore : NSObject
{
    NSMutableArray* allAssignments;
    NSMutableArray* allGrades;
    NSDictionary* gradesDict;
}

+ (SSVDataStore*)sharedStore;
- (void)emptyDataStore;
- (void)populateAssignments:(NSArray*)data;
- (void)populateGrades:(NSArray*)data;

// Accessors/mutators
- (NSArray*)allAssignments;
- (NSMutableArray*)allGrades;

@end
