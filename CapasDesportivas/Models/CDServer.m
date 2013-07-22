//
//  CDServer.m
//  SportsCovers
//
//  Created by Developer on 7/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDServer.h"
#import "ASIFormDataRequest.h"

@implementation CDServer
{
    
}
SINGLETON(CDServer)

- (NSString *)getHostURL
{
    return kDevURL;
}
- (void)setProgress:(float)newProgress;
{
   // [MBProgressHUD :newProgress status:@"Loading"];
    if (_progressIndicator) {
         _progressIndicator.progress = newProgress;
    }
   
    
}

- (void)printRequest:(NSString *)path withData:(NSDictionary *)data
{
    XLog(@"Calling -> %@\nWith Data -> %@", path, data);
}
- (void)createGETRequestToPath:(NSString *)path andOnFinish:(void (^)(NSData *response))blockOnFinish
{
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[self getHostURL], path]];
    XLog(@"\n\nCalling URL [POST] -> %@\n\n", targetURL);
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:targetURL];
    //[SVProgressHUD showProgress:0 status:@"Loading"];
    [request setRequestMethod:@"GET"];
    [request setCompletionBlock:^{
       // [SVProgressHUD dismiss];
        
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        blockOnFinish(responseData);
    }];
    [request setFailedBlock:^{
        //[SVProgressHUD dismiss];
        NSError *error = [request error];
    }];
    [request startAsynchronous];
    
}

- (void)createPOSTRequestToPath:(NSString *)path withDataToSend:(NSDictionary *)dictionary andOnFinish:(void (^)(NSData *response))blockOnFinish
{
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[self getHostURL], path]];
    XLog(@"\n\nCalling URL [POST] -> %@\n\n", targetURL);
    __block NSMutableDictionary *mutDictionary = [dictionary mutableCopy];
    if (mutDictionary == nil) {
        mutDictionary = [NSMutableDictionary new];
    }
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:targetURL];
   // [SVProgressHUD showProgress:0 status:@"Loading"];
    [request setDownloadProgressDelegate:self];
    [request setRequestMethod:@"POST"];
    if(![dictionary objectForKey:@"userID"]){
       // [mutDictionary setValue:[RPUser currentUser].UserID forKey:@"userID"];
    }
    if(![dictionary objectForKey:@"TokenUserID"]){
       // [mutDictionary setValue:[RPUser currentUser].UserID forKey:@"TokenUserID"];
    }
    if(![dictionary objectForKey:@"TokenID"]){
       // [mutDictionary setValue:[RPUser currentUser].TokenID forKey:@"TokenID"];
    }
    if (mutDictionary != nil) {
        [self addDataFrom:mutDictionary toRequest:request];
    }
    [self printRequest:path withData:mutDictionary];
    [request setCompletionBlock:^{
       // [SVProgressHUD dismiss];
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        blockOnFinish(responseData);
    }];
    [request setFailedBlock:^{
       // [SVProgressHUD dismiss];
        NSError *error = [request error];
    }];
    [request startAsynchronous];
    
    
}
-(NSDictionary *)addUserLogin:(NSDictionary *)dictionary
{
    return nil;
}
- (void)createSincPostRequestToPath:(NSString *)path withDataToSend:(NSDictionary *)dictionary andOnFinish:(void (^)(NSData *response))blockOnFinish
{
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[self getHostURL], path]];
    XLog(@"\n\nCalling URL [POST] -> %@\n\n", targetURL);
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:targetURL];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        blockOnFinish(responseData);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
    }];
    [request startSynchronous];
}

- (NSDictionary *)createSincPostRequestToPathAndReceiveDictionary:(NSString *)path withDataToSend:(NSDictionary *)dictionary {
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[self getHostURL], path]];
    XLog(@"\n\nCalling URL [POST] -> %@\n\n", targetURL);
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:targetURL];
    if (dictionary) {[self addDataFrom:dictionary toRequest:request];}
   // [SVProgressHUD showProgress:0 status:@"Loading"];
    [request setDownloadProgressDelegate:self];
    [request setRequestMethod:@"GET"];
    NSError *error;
    NSDictionary *items;
    // long-running code
    [request startSynchronous];
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    
    items = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    //for (NSString *item in [items allKeys])
    NSString *retVal = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
 //   [SVProgressHUD dismiss];
    if (!error) {
        return items;
    }else{
        return nil;
    }
}

- (void)addDataFrom:(NSDictionary *)data toRequest:(ASIFormDataRequest *)req
{
    for (NSString *key in [data allKeys]) {
        [req setPostValue:[data objectForKey:key] forKey:key];
        XLog(@"POST VALUE =>%@: %@",key, [data objectForKey:key]);
    }
}

- (void)createNewUser:(NSDictionary *)userInformation andOnFinish:(void (^)(NSDictionary *finish))blockOnFinish
{
    [self createPOSTRequestToPath:kUserRegistration
                   withDataToSend:userInformation
                      andOnFinish:^(NSData *data) {
                          NSError *error;
                          NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                          //for (NSString *item in [items allKeys])
                          NSString *retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                          XLog(@"%@", items);
                          if (!error) {
                              blockOnFinish(items);
                          }else{
                              blockOnFinish(nil);
                          }
                          
                      
                }];
}

- (void)logInUser:(NSDictionary *)userInformation andOnFinish:(void (^)(NSDictionary *finish))blockOnFinish
{
    [self createPOSTRequestToPath:kUserLogin
                   withDataToSend:userInformation
                      andOnFinish:^(NSData *data) {
                          NSError *error;
                          NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                          //for (NSString *item in [items allKeys])
                          NSString *retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                          XLog(@"%@", items);
                          if (!error) {
                              blockOnFinish(items);
                          }else{
                              blockOnFinish(nil);
                          }
                          
                          
                      }];
}

- (void)getAllDataAndOnFinish:(void (^)(BOOL finish))blockOnFinish
{
    [self createPOSTRequestToPath:kAllDataNewspapers
                   withDataToSend:nil
                      andOnFinish:^(NSData *data) {
                          NSError* error;
                          NSDictionary* json = [NSJSONSerialization
                                                JSONObjectWithData:data
                                                
                                                options:NSJSONReadingMutableLeaves
                                                error:&error];
                          if ([json objectForKey:@"links"]) {
                              NSArray *links = [json objectForKey:@"links"];
                              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                              NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:links];
                              [defaults setObject:data2 forKey:kApplicationLinks];
                              blockOnFinish(YES);
                          } else {
                              blockOnFinish(NO);
                          }

                          
                          
                          
                      }];
}



@end
