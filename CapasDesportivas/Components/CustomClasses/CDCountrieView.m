//
//  CDCountrieView.m
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountrieView.h"

@implementation CDCountrieView

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kCountrieViewWidth, kCountrieViewHeight)];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSString *countrie = [_options objectForKey:@"name_en"];
    _countryFlag = [[CHAvatarView alloc] initWithFrame:CGRectMake(2, 0, 70, 70)];
    _countryFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[countrie lowercaseString]]];
    [_countryFlag setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:_countryFlag];
    
    _countryName = [[CDCustomFontLabel alloc]initWithFrame:CGRectMake(75, 0, kCountrieViewWidth - 80, 50)];
    [_countryName setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:30]];
    [_countryName setText:[_options objectForKey:@"name_en"]];
    
    [self addSubview:_countryName];
    
    _newspaperName = [[CDCustomFontLabel alloc]initWithFrame:CGRectMake(77, 45, kCountrieViewWidth - 80, 23)];
    [_newspaperName setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [_newspaperName setText:[_options objectForKey:@"name"]];
    
    [self addSubview:_newspaperName];
    
    
}

@end
