//
//  SSVAppDelegate.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <dispatch/dispatch.h>
#import "SSVAppDelegate.h"
#import "SSVTableViewController.h"
#import "SSVLoginViewController.h"
#import "SSVCustomURLProtocol.h"
#import "SSVMyschoolChecker.h"
#import "SSVGradesTableViewController.h"
#import "SSVDataStore.h"
#import "SSVMenuViewController.h"

@implementation SSVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [NSURLProtocol registerClass:[SSVCustomURLProtocol class]];
    
    // Create Tab bar controller
    UITabBarController* tbc = [[UITabBarController alloc] init];
    [[tbc tabBar] setBarStyle:UIBarStyleDefault];
    [[tbc tabBar] setTintColor:[UIColor redColor]];
    [[tbc tabBar] setTranslucent:NO];
    
    // Create new TableViewController
    SSVTableViewController* tvc = [[SSVTableViewController alloc ] initWithStyle:UITableViewStylePlain];
    SSVGradesTableViewController* gtvc = [[SSVGradesTableViewController alloc]init];
    
    
    // Create SSVMenuViewController
    SSVMenuViewController* mvc = [[SSVMenuViewController alloc] init];
    
    
    // Create UINavigationController
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:tvc];
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:gtvc];
    UINavigationController* nav3 = [[UINavigationController alloc] initWithRootViewController:mvc];

    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    [tbc setViewControllers:[NSArray arrayWithObjects:nav, nav2, nav3, nil]];

    [[self window] setRootViewController:tbc];
    
    
    
    // NSUserDefaults
    // initialize defaults
    NSString *dateKey    = @"dateKey";
    NSDate *lastRead    = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:dateKey];
    if (lastRead == nil)     // App first run: set up user defaults.
    {
        NSDictionary *appDefaults  = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate date], dateKey, nil];
        
        // do any other initialization you want to do here - e.g. the starting default values.
        // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"should_play_sounds"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Authentication"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Zoomed"];
        
        // sync the defaults to disk
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //[[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Authentication"];
    //[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Zoomed"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:dateKey];
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
