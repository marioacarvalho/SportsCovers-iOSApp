//
//  CDCountryAvatarAndNameButton.m
//  SportsCovers
//
//  Created by Developer on 7/20/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountryAvatarAndNameButton.h"

@implementation CDCountryAvatarAndNameButton

-(id)initWithFrame:(CGRect)frame AndWithArray:(NSDictionary *)info;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _data = info;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self setBackgroundColor:[UIColor clearColor]];
    NSString *countrie = [_data objectForKey:@"name_en"];
    _countryFlag = [[CHAvatarView alloc] initWithFrame:CGRectMake(rect.size.width/4, 5, 65, 65)];
    _countryFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[countrie lowercaseString]]];
    [_countryFlag setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:_countryFlag];
    
    _countryName = [[CDCustomFontLabel alloc]initWithFrame:CGRectMake(0, 70, self.frame.size.width, 25)];
    [_countryName setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20]];
    [_countryName setText:[_data objectForKey:@"name_en"]];
    [_countryName setTextAlignment:NSTextAlignmentCenter];
    [_countryName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_countryName];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [tap setNumberOfTapsRequired:2];
    [tap setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:tap];
}


-(void)doubleTap:(UITapGestureRecognizer *)recognizer
{
    [self.delegate clickedInButtonWithCountryID:[_data objectForKey:@"id"]];
}
@end
