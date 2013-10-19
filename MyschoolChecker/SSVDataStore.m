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
    
    for(int i = 0; i < [data count] - 1 ; i++){
        [allGrades addObject:[[SSVGrade alloc] init]];
        
    }
    int editing = 0;
    for (TFHppleElement* element in data) {
        if([element hasChildren]){
            int counter = 0;
            for(TFHppleElement* child in [element children]){
                if([child text]){
                    NSTextCheckingResult *match = [regex firstMatchInString:[child text] options:0 range:NSMakeRange(0, [[child text] length])];
                    if(match){
                        NSLog(@"Match!");
                        NSLog(@"child text: %@", [child text]);
                    }
                    switch (counter) {
                        case 0:
                            [[allGrades objectAtIndex:editing] setGrade:[child text]];
                            break;
                        case 1:
                            [[allGrades objectAtIndex:editing] setOrder:[child text]];
                        case 2:
                            [[allGrades objectAtIndex:editing] setFeedback:[child text]];
                        default:
                            break;
                    }
                    counter++;
                }
                if([child hasChildren]){
                    for (TFHppleElement* grandchild in [child children]) {
                        if ([grandchild text]) {
                            [[allGrades objectAtIndex:editing] setAssignmentName:[grandchild text]];
                        }
                    }
                }
            }
            editing++;
        }
    }
}
@end
