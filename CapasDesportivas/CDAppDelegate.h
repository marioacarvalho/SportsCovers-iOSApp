//
//  CDAppDelegate.h
//  CapasDesportivas
//
//  Created by Developer on 7/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "IIViewDeckController.h"
#import "Appirater.h"

@interface CDAppDelegate : UIResponder <UIApplicationDelegate, AppiraterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IIViewDeckController *deck;
@end
