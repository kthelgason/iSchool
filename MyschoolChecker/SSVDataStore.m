//
//  SSVDataStore.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVAssignment.h"
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

- (void)emptyDataStore{
    [allAssignments removeAllObjects];
}

// This method disgusts me, Parsing the HTML tree should not be done like this.
// Needs refactoring
-(void)populateData:(NSArray*)data{
    
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
@end
