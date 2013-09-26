//
//  SSVAppDelegate.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVAppDelegate.h"
#import "SSVUser.h"
#import "SSVTableViewController.h"
#import "SSVLoginViewController.h"
#import "SSVCustomURLProtocol.h"
#import "SSVMyschoolChecker.h"
#import "SSVDataStore.h"

@implementation SSVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [NSURLProtocol registerClass:[SSVCustomURLProtocol class]];
    
    // Create new TableViewController
    SSVTableViewController* tvc = [[SSVTableViewController alloc ] initWithStyle:UITableViewStylePlain];
    
    // Create UINavigationController
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:tvc];

    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    // set it as root view controller
    [[self window] setRootViewController:nav];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    NSString* dataPath = [[SSVUser user]userDataPath];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataPath])
    {
        SSVUser* user = [SSVUser user];
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    }
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Archive the user data to file to be loaded when application launches
    
    BOOL success = [[SSVUser user]saveChanges];
    if(success){
        NSLog(@"Saved user data!");
    } else {
        NSLog(@"Could not save data :(");
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
