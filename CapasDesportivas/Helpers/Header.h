//
//  Header.h
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#ifndef CapasDesportivas_Header_h
#define CapasDesportivas_Header_h

//DEFINES
#ifdef DEBUG
#define XLog(__xx, ...)  NSLog(@"%s(%d): " __xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define XLog(__xx, ...)  ((void)0)
#endif

//URLS
#define kDevURL @"http://194.14.179.154/sportsCover/index.php/API/"
#define kDeployURL @"http://194.14.179.154/sportsCover/index.php/API_current/"

#define kCoverSupporterHeight   290
#define kCoverSupporterWidth    205

#define kSupporterHeight   389
#define kSupporterWidth    320

#define kCoverX   66
#define kCoverY    42
#define kCoverHeight   290
#define kCoverWidth    205

#define kCountrieViewWidth   245
#define kCountrieViewHeight    73


#define kApplicationLinks       @"kLinks"
#define kCountriesNeedsVerticalScroll @"CountriesNeedsVerticalScroll"
#define kJumpToCountry @"JumpToCountry"
#define kAllCountriesIdsAndCollumnsRelation @"kAllCountriesIdsAndCollumnsRelation"

#ifndef SINGLETON
#define SINGLETON(classname)                        \
\
+ (classname *)sharedInstance {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif


#define kUserRegistration @"users/registerWithEmail"
#define kUserLogin @"users/logInUser"
#define kAllDataNewspapers @"main/getLinks"

#define kLoginComplete @"loginComplete"
#define kLoggedInUser @"loggedInUser"
#endif
