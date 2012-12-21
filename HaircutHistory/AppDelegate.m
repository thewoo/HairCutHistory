//
//  AppDelegate.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize navController;


#pragma mark Actions.

+(void)checkAndCopyFileWithName:(NSString *)name ofType:(NSString *)type {
    
    NSString *roothPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [roothPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", name, type]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:filePath error:nil];
    }
}


#pragma mark AppDelegate's.

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    mainViewController.title = NSLocalizedString(@"mainViewController.title", nil);
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self.navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    [self.window setRootViewController:self.navController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
