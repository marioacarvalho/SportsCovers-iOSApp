//
//  CDServer.h
//  SportsCovers
//
//  Created by Developer on 7/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface CDServer : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>

+ (CDServer *) sharedInstance;
@property (nonatomic, strong) MBProgressHUD *progressIndicator;
//USERS
- (void)createNewUser:(NSDictionary *)userInformation andOnFinish:(void (^)(NSDictionary *finish))blockOnFinish;
- (void)logInUser:(NSDictionary *)userInformation andOnFinish:(void (^)(NSDictionary *finish))blockOnFinish;

//DATA
- (void)getAllDataAndOnFinish:(void (^)(BOOL finish))blockOnFinish;
@end
