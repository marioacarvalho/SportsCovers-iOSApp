//
//  CDFlagAndScrollableContentView.m
//  SportsCovers
//
//  Created by Developer on 7/18/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDFlagAndScrollableContentView.h"

@implementation CDFlagAndScrollableContentView

#define kCountryNameAndNewsPaperNameWidth 180
#define kCountryNameAndNewsPaperNameHeight 75

#define kCountryNameLabelHeight 45
#define kNewsPaperNameLabelHeight 30

-(id)initWithFrame:(CGRect)frame AndWithArray:(NSArray *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _data = info;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self setBackgroundColor:[UIColor clearColor]];
    NSString *countrie = [[_data lastObject] objectForKey:@"name_en"];
    _countryFlag = [[CHAvatarView alloc] initWithFrame:CGRectMake(5, 5, 65, 65)];
    _countryFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[countrie lowercaseString]]];
    [_countryFlag setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:_countryFlag];
    
    [self setBackgroundColor:[UIColor clearColor]];
    _countryName = [[CDCustomFontLabel alloc]initWithFrame:CGRectMake(75, 5, self.frame.size.width, kCountryNameLabelHeight)];
    [_countryName setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:30]];
    [_countryName setText:[[_data lastObject] objectForKey:@"name_en"]];
    [_countryName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_countryName];
    
    _scrollView = [[CDCountriesScrollView alloc] initWithFrame:CGRectMake(70, kCountryNameLabelHeight, self.frame.size.width, kCountryNameLabelHeight) andWithArray:_data];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_scrollView];
    
}


@end
