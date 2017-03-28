//
//  AppDelegate.m
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/21.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import "AppDelegate.h"
#import "DBPersistance.h"
#import "User.h"
#import "NSObject+DBPExtension.h"
#import "objc/runtime.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [DBPTableOperator setEncrypt:YES];
    
    User *user = [[User alloc] init];
    user.userId = @"sdff";
    user.age = 18;
    user.birthday = [NSDate date];
    user.height = 14.5;
    user.married = NO;
    user.address = [[Address alloc] init];
    
    //unsigned int count;
    //objc_property_t *properties = class_copyPropertyList([user class], &count);
    //NSLog(@"%@",properties[0]);
    
    NSLog(@"userId NSString : %@",[user propertyAttributesWithName:@"userId"]);
    NSLog(@"age NSInteger : %@",[user propertyAttributesWithName:@"age"]);
    NSLog(@"birthday NSDate : %@",[user propertyAttributesWithName:@"birthday"]);
    NSLog(@"height CGFloat : %@",[user propertyAttributesWithName:@"height"]);
    NSLog(@"married BOOL : %@",[user propertyAttributesWithName:@"married"]);
    NSLog(@"address Address : %@",[user propertyAttributesWithName:@"address"]);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
