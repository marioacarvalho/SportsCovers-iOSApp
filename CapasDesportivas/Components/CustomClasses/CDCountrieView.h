//
//  CDCountrieView.h
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHAvatarView.h"
@interface CDCountrieView : UIView


-(id)init;
@property (nonatomic, strong) CHAvatarView *countryFlag;
@property (nonatomic, strong) CDCustomFontLabel *countryName;
@property (nonatomic, strong) CDCustomFontLabel *newspaperName;
@property (nonatomic, strong) NSDictionary *options;




@end
