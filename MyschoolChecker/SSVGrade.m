//
//  SSVGrade.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 9.10.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVGrade.h"

@implementation SSVGrade

@synthesize assignmentName, grade, order, feedback, inCourse;

// Isolate the rank from the @"Röð: x - y" string.
-(NSString*)getRank
{
    if(self.order.length > 1) // Because reasons.
    {
        NSMutableString* str = [NSMutableString stringWithString:[self order]];
        NSRange range = {0, 5};
        [str deleteCharactersInRange:range];
        NSString* rank = [NSString stringWithString:str];
        return rank;
    }
    else
    {
        return @"";
    }
}

-(NSString*)getGrade
{
    if(self.grade.length > 1) // Because reasons.
    {
        NSMutableString* str = [NSMutableString stringWithString:[self grade]];
        NSRange range = {0, 9};
        [str deleteCharactersInRange:range];
        NSString* theGrade = [NSString stringWithString:str];
        return theGrade;
    }
    else
    {
        return @"";
    }
}

-(NSString*)getCourse
{
    NSMutableString* str = [NSMutableString stringWithString:self.inCourse];
    int index = 0;
    for(int i = 0; i < str.length; i++)
    {
        if([str characterAtIndex:i] == ' ')
        {
            index = i;
            break;
        }
    }
    NSRange range = {0, index + 1};
    [str deleteCharactersInRange:range];
    NSString* course = [NSString stringWithString:str];
    return course;
}

@end
