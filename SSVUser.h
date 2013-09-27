//
//  SSVUser.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 26.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SSVUser : NSManagedObject

@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;

+(id)user;
-(NSString*)getAuth;

@end
