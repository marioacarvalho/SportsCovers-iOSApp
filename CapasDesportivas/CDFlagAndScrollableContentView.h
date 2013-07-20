//
//  CDFlagAndScrollableContentView.h
//  SportsCovers
//
//  Created by Developer on 7/18/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHAvatarView.h"
#import "CDCountriesScrollView.h"
@interface CDFlagAndScrollableContentView : UIView

-(id)initWithFrame:(CGRect)frame AndWithArray:(NSArray *)info;

@property (nonatomic, strong) CDCustomFontLabel *countryName;
@property (nonatomic, strong) CHAvatarView *countryFlag;
@property (nonatomic, strong) CDCountriesScrollView *scrollView;
@property (nonatomic, strong) NSArray *data;

@end
