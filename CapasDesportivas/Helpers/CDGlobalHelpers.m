//
//  CDGlobalHelpers.m
//  SportsCovers
//
//  Created by Developer on 7/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDGlobalHelpers.h"

void handleErrorWith(NSDictionary *errorDic)
{
    XLog(@"HANDLE ERROR \n %@\n", errorDic);
}

void saveUserInformation(NSDictionary *userInformation)
{
    [[NSUserDefaults standardUserDefaults] setObject:userInformation forKey:kLoggedInUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

