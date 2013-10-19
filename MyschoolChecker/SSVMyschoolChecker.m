//
//  SSVMyschoolChecker.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 21.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVMyschoolChecker.h"
#import "TFHpple.h"

@implementation SSVMyschoolChecker

+ (NSArray*)fetchAssignments{
    NSLog(@"Fetching assignment data from myschool...");
    NSURL* myschoolConnection = [NSURL URLWithString:@"https://myschool.ru.is/myschool/?Page=Exe&ID=1.12"];
    
    NSString* basicAuthentication = [[NSUserDefaults standardUserDefaults] objectForKey:@"Authentication"];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:myschoolConnection];
    [urlRequest setValue:basicAuthentication forHTTPHeaderField:@"Authorization"];
    NSData* requestData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSArray* Nodes;
    if(requestData){
        TFHpple* htmlParser = [TFHpple hppleWithHTMLData:requestData];
        NSString* XpathQueryString = @"//div[@class='ruContentPage']/center/table[@class='ruTable']/tbody/tr";
        
        Nodes = [htmlParser searchWithXPathQuery:XpathQueryString];
    }
//    for (TFHppleElement* element in Nodes) {
//        if([element hasChildren]){
//            for(TFHppleElement* child in [element children]){
//                NSLog([child text]);
//            }
//        }
//    }

    return Nodes;
}

+ (NSArray*)fetchGrades{
    NSLog(@"Fetching grade data from myschool...");
    NSURL* myschoolConnection = [NSURL URLWithString:@"https://myschool.ru.is/myschool/?Page=Exe&ID=1.12"];
    
    NSString* basicAuthentication = [[NSUserDefaults standardUserDefaults] objectForKey:@"Authentication"];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:myschoolConnection];
    [urlRequest setValue:basicAuthentication forHTTPHeaderField:@"Authorization"];
    NSData* requestData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSArray* Nodes;
    if(requestData){
        TFHpple* htmlParser = [TFHpple hppleWithHTMLData:requestData];
        NSString* XpathQueryString = @"//div[@class='ruContentPage']/center[2]/table/tbody/tr";
        
        Nodes = [htmlParser searchWithXPathQuery:XpathQueryString];
    }
    
    return Nodes;
}

+ (BOOL)checkAuthstring:(NSString*)authString{
    return [[SSVMyschoolChecker fetchAssignments] count] == 0 ? NO : YES;
}


@end
