//
//  SSVUser.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 24.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSVUser : NSObject <NSCoding>

@property(nonatomic, copy)NSString* loginName;
@property(nonatomic, copy)NSString* password;

+(id)user;
-(NSString*)getAuth;

// Archive data
-(BOOL)saveChanges;
// get path to user data archive
-(NSString*)userDataPath;

@end
