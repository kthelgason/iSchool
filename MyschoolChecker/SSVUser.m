//
//  SSVUser.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 24.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVUser.h"

@implementation SSVUser

@synthesize loginName, password;

+(id)user{
    static SSVUser* user = nil;
    if (!user) {
        user = [[SSVUser alloc] init];
    }
    return user;
}

- (id)init{
    self = [super init];
    if(self){
        // yey!
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    [self setLoginName:[aDecoder valueForKey:@"loginName"]];
    [self setPassword:[aDecoder valueForKey:@"password"]];
    return self;
}

-(NSString*)userDataPath{
    NSArray* docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* document = [docDirs objectAtIndex:0];
    return [document stringByAppendingPathComponent:@"user.archive"];
}


-(BOOL)saveChanges{
    NSString* path = [self userDataPath];
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}


// Encode user data on exit
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:loginName forKey:@"loginName"];
    [aCoder encodeObject:password forKey:@"password"];
}

-(NSString*)getAuth{
    NSString* string = [NSString stringWithFormat:@"%@:%@",[self loginName],[self password]];
    NSString *base64EncodedString = [[string dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString* basicAuthentication = [NSString stringWithFormat:@"Basic %@",base64EncodedString];
    return basicAuthentication;
}

@end
