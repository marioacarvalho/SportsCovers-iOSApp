//
//  CDCountryAvatarAndNameButton.h
//  SportsCovers
//
//  Created by Developer on 7/20/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//
@protocol CDCountryAvatarAndNameButtonDelegate <NSObject>
@required
-(void)clickedInButtonWithCountryID:(NSString *)countryID;

@end
#import <UIKit/UIKit.h>
#import "CHAvatarView.h"

@interface CDCountryAvatarAndNameButton : UIButton<UIGestureRecognizerDelegate>

-(id)initWithFrame:(CGRect)frame AndWithArray:(NSDictionary *)info;

@property (nonatomic, strong) CHAvatarView *countryFlag;
@property (nonatomic, strong) CDCustomFontLabel *countryName;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, weak) id <CDCountryAvatarAndNameButtonDelegate> delegate;

@end
