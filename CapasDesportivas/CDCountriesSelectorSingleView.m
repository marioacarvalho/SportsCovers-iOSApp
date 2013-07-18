//
//  CDCountriesSelectorSingleView.m
//  CapasDesportivas
//
//  Created by Developer on 7/11/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountriesSelectorSingleView.h"
#import "CHAvatarView.h"


@implementation CDCountriesSelectorSingleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    
}

-(void)didMoveToSuperview{
    // Drawing code

}
- (void)addCountries
{
    
    int i = 0;
    int j = 1;
    for (NSDictionary *dic in _countriesInfo) {
        if (i % 2 != 0) {
            CHAvatarView *country = [[CHAvatarView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width + countrySize,
                                                                                   [[UIScreen mainScreen] bounds].size.height + countrySize,
                                                                                   countrySize,
                                                                                   countrySize)];
            country.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[dic objectForKey:@"name_en"] lowercaseString]]];
            [country setBackgroundColor:[UIColor clearColor]];
            [self addSubview:country];
            [self animateViewEntryFor:j forView:country andIsLeft:NO];
            j++;
        } else {
            CHAvatarView *country = [[CHAvatarView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width + countrySize,
                                                                                   [[UIScreen mainScreen] bounds].size.height + countrySize,
                                                                                   countrySize,
                                                                                   countrySize)];
            country.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[dic objectForKey:@"name_en"] lowercaseString]]];
            [country setBackgroundColor:[UIColor clearColor]];
            [self addSubview:country];
            [self animateViewEntryFor:j forView:country andIsLeft:YES];

        }
        i++;


    }
}

-(void)animateViewEntryFor:(int)j forView:(CHAvatarView *)view andIsLeft:(BOOL)isLeft
{
    if (isLeft) {
        [UIView animateWithDuration:.15 animations:^{
            [view setFrame:CGRectMake(leftX, (leftY * j)+(countrySize*(j - 1)), countrySize, countrySize)];
        }];

    } else {
        [UIView animateWithDuration:.15 animations:^{
            [view setFrame:CGRectMake(rightX, (rightY * j)+(countrySize*(j - 1)), countrySize, countrySize)];
        }];
    }
}


@end
