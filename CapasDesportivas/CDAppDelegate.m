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
#import "CDMainIntroViewController.h"

@implementation CDAppDelegate
{
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    [Crashlytics startWithAPIKey:@"dd816aba0d2461ef776749ca20840a7a30eb017f"];
    [TestFlight takeOff:@"336bcf91-f352-479c-acd6-c7e33a015ccf"];
   // [[LocalyticsSession shared] startSession:@"7792d304ce350d24d9e1272-76b451ea-ee4c-11e2-8f8a-009c5fda0a25"];
    
 /*
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
    [imageCache cleanDisk];
  */
    [Appirater setAppId:@"552035781"];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:2];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDelegate:self];
   // [Appirater setDebug:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[self performSelectorInBackground:@selector(loadInBackground)withObject:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMainInterface) name:kLoginComplete object:nil];
    CDMainIntroViewController *main = [[CDMainIntroViewController alloc]init];
    [self.window setRootViewController:main];
    [self.window makeKeyAndVisible];
    [Appirater appLaunched:YES];

    
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
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

- (void)loadInBackground
{
    //do your loading here
    //this is in the background, so don't try to access any UI elements
    [self grabURLInBackground:nil withBlockOnFinish:^(NSData *data) {
        [self performSelectorOnMainThread:@selector(finishedLoading:) withObject:data waitUntilDone:NO];
    }];

    
}

- (void)finishedLoading:(NSData *)data
{
    //back on the main thread now, it's safe to show your view controller

    // Override point for customization after application launch.
    
    
    
    

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

- (void)loadMainInterface
{
    _deck =  [[IIViewDeckController alloc] initWithCenterViewController:[[CDRootViewController alloc] init]
                                                     leftViewController:nil
                                                    rightViewController:nil];
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ self.window.rootViewController = _deck; }
                    completion:nil];
}


@end
