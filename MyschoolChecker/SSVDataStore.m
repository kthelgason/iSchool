//
//  SSVDataStore.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVAssignment.h"
#import "SSVGrade.h"
#import "SSVDataStore.h"
#import "TFHpple.h"

@implementation SSVDataStore

+ (SSVDataStore*)sharedStore{
    static SSVDataStore* sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

- (id)init{
    self = [super init];
    if(self){
        allAssignments = [[NSMutableArray alloc] init];
        allGrades = [[NSMutableArray alloc] init];
    }
    return self;
}

// Override allocation method to ensure duplicates never get constructed
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedStore];
}

- (NSArray*)allAssignments{
    return allAssignments;
}

- (NSArray*)allGrades{
    return allGrades;
}

-(NSDictionary*)gradesDictionary{
    return gradesDict;
}

- (void)emptyDataStore{
    [allAssignments removeAllObjects];
}

// This method disgusts me, Parsing the HTML tree should not be done like this.
// Needs refactoring
-(void)populateAssignments:(NSArray*)data{
    
    for(int i = 0; i < [data count] - 1; i++){
        [allAssignments addObject:[[SSVAssignment alloc] init]];
        
    }
    int editing = 0;
    for (TFHppleElement* element in data) {
        if([element hasChildren]){
            int counter = 0;
            for(TFHppleElement* child in [element children]){
                if([child text]){
                    switch (counter) {
                        case 0:
                            [[allAssignments objectAtIndex:editing] setDueDate:[[child text] substringToIndex:5]];
                            break;
                        case 1:
                            [[allAssignments objectAtIndex:editing] setHandedIn:[child text]];
                        case 2:
                            [[allAssignments objectAtIndex:editing] setCourseId:[child text]];
                        case 3:
                            [[allAssignments objectAtIndex:editing] setCourseName:[child text]];
                        default:
                            break;
                    }
                    counter++;
                }
                if([child hasChildren]){
                    for (TFHppleElement* grandchild in [child children]) {
                        if ([grandchild text]) {
                            [[allAssignments objectAtIndex:editing] setTitle:[grandchild text]];
                        }
                        if([[grandchild tagName]  isEqual: @"a"]){
                            [[allAssignments objectAtIndex:editing] setAssignmentURL:[grandchild objectForKey:@"href"]];
                        }
                    }
                }
            }
            editing++;
        }
    }
    if([allAssignments count] > 1){
        [allAssignments removeObjectAtIndex:0];
    }
}

-(void)populateGrades:(NSArray*)data{
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"\\bT-[0-9]{3}-.*\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    NSMutableArray* grades = [[NSMutableArray alloc] init];
    int editing = 0;
    NSString* currentCourse = nil;
    for (TFHppleElement* element in data) {
        SSVGrade* thisGrade = [[SSVGrade alloc] init];
        if([element hasChildren]){
            int counter = 0;
            for(TFHppleElement* child in [element children]){
                if([child text]){
                    NSTextCheckingResult *match = [regex firstMatchInString:[child text] options:0 range:NSMakeRange(0, [[child text] length])];
                    if(match){
                        currentCourse = [child text];
                        NSLog(@"Match!");
                        NSLog(@"child text: %@", [child text]);
                        continue;
                    }
                    switch (counter) {
                        case 0:
                            [thisGrade setGrade:[child text]];
                            break;
                        case 1:
                            [thisGrade setOrder:[child text]];
                        case 2:
                            [thisGrade setFeedback:[child text]];
                        default:
                            break;
                    }
                    [thisGrade setInCourse:currentCourse];
                    counter++;
                }
                if([child hasChildren]){
                    for (TFHppleElement* grandchild in [child children]) {
                        if ([grandchild text]) {
                            [thisGrade setAssignmentName:[grandchild text]];
                        }
                    }
                }
            }
            [grades addObject:thisGrade];
        }
    }
    // This is awesome! Didn't know Obj-C had this block syntax
    [grades sortUsingComparator:^(SSVGrade* obj1, SSVGrade* obj2){
        return (NSComparisonResult)[obj1.inCourse compare:obj2.inCourse];
    }];
    NSString* thisCourseName = [[grades objectAtIndex:0] inCourse];
    // Loop through all the grades
    for(int i = 0; i < grades.count - 1; ++i){
        // Create an array for the current course
        NSMutableArray* thisCourse = [[NSMutableArray alloc] init];
        thisCourseName = [[grades objectAtIndex:i] inCourse];
        // While we are still in that course, push the grade
        while([[[grades objectAtIndex:i] inCourse] isEqualToString:thisCourseName] && i < grades.count - 1)
        {
            if([[grades objectAtIndex:i] assignmentName] != nil){
                [thisCourse addObject:[grades objectAtIndex:i]];
            }
            i++;
        }
        
        //Push new array to the data store
        if(thisCourse.count > 0){
            [[[SSVDataStore sharedStore] allGrades] addObject: thisCourse];
        }
    }
    
}
@end
