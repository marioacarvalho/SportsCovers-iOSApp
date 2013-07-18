//
//  CDAppDelegate.m
//  CapasDesportivas
//
//  Created by Developer on 7/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDAppDelegate.h"
#import "CDRootViewController.h"
#import "SDImageCache.h"
#import <Crashlytics/Crashlytics.h>
#import "LocalyticsSession.h"

@implementation CDAppDelegate
{
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    [Crashlytics startWithAPIKey:@"dd816aba0d2461ef776749ca20840a7a30eb017f"];
    [TestFlight takeOff:@"336bcf91-f352-479c-acd6-c7e33a015ccf"];
    [[LocalyticsSession shared] startSession:@"7792d304ce350d24d9e1272-76b451ea-ee4c-11e2-8f8a-009c5fda0a25"];
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
    [imageCache cleanDisk];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self grabURLInBackground:nil withBlockOnFinish:^(NSData *data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.window animated:YES];
            });
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  
                                  options:NSJSONReadingMutableLeaves
                                  error:&error];
            NSArray *links = [json objectForKey:@"links"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:links];
            [defaults setObject:data2 forKey:kApplicationLinks];
            // Override point for customization after application launch.
            
        
            _deck =  [[IIViewDeckController alloc] initWithCenterViewController:[[CDRootViewController alloc] init]
                                                             leftViewController:nil
                                                            rightViewController:[[CDRootViewController alloc] init]];
            
            [self.window setRootViewController:_deck];
            [self.window makeKeyAndVisible];

            
            
        }];
        
        
    });

    
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (IBAction)grabURLInBackground:(id)sender withBlockOnFinish:(void (^)(NSData*))blockOnFinish;
{
//    for (NSString *familyName in [UIFont familyNames]) {
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            NSLog(@"%@", fontName);
//        }
//    }
    
    NSURL *url = [NSURL URLWithString:@"http://194.14.179.154/sportsCover/index.php/API/main/getLinks"];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSData *responseData = [request responseData];
        blockOnFinish(responseData);
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
    }];
    [request startAsynchronous];
}


@end
