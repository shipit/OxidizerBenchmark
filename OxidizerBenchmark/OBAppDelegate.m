//
//  OBAppDelegate.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OBAppDelegate.h"
#import "AFNetworking.h"
#import "Oxidizer.h"
#import "OBTestController.h"

@implementation OBAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:[[[OBTestController alloc] init]autorelease]] autorelease];
    self.window.rootViewController = nc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) testAF {
    NSLog(@"testAF()");
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://apple.com"]];
    [client getPath:@"/" parameters:nil 
            success:^(AFHTTPRequestOperation *operation , id responseObject) {
                NSLog(@"SUCCESS response = %@", responseObject);
            }
     
            failure:^(AFHTTPRequestOperation *operation , NSError *error) {
                NSLog(@"ERROR = %@", error);
            }];

}

- (void) testComet {
    NSArray *connectionList = [NSArray arrayWithObjects:@"long-polling", @"callback-polling", nil];
    
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:@"1" forKey:@"id"];
    [params setObject:@"/meta/handshake" forKey:@"channel"];
    [params setObject:@"1.0"             forKey:@"version"];
    [params setObject:connectionList     forKey:@"supportedConnectionTypes"];
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://lvho.st:8080"]];
    [client setParameterEncoding:AFJSONParameterEncoding];
    
    NSURLRequest *request = [client requestWithMethod:@"POST" path:@"/tophatter/cometd" parameters:params];
    NSLog(@"REQUEST = %@", request);
    
    AFJSONRequestOperation *jsonRequest = 
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSLog(@"SUCCESS response = %@", JSON);
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"ERROR = %@", error);
                                                    }];    
    [client enqueueHTTPRequestOperation:jsonRequest];
}

- (void) testOX {
    Oxidizer *ox = [Oxidizer connector];
    [ox handshakeWithUrl:@"http://lvho.st:8080/tophatter/cometd"];
    [ox release];
}

@end
