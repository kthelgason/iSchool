//
//  SSVUser.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 26.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVUser.h"


@implementation SSVUser

@dynamic loginName;
@dynamic password;

+(id)user{
    static SSVUser* user = nil;
    if (!user) {
        user = [[SSVUser alloc] init];
    }
    return user;
}



-(NSString*)getAuth{
    NSString* string = [NSString stringWithFormat:@"%@:%@",[self loginName],[self password]];
    NSString *base64EncodedString = [[string dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString* basicAuthentication = [NSString stringWithFormat:@"Basic %@",base64EncodedString];
    return basicAuthentication;
}



@end
