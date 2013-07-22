//
//  CDCountriesSelectorSingleView.m
//  CapasDesportivas
//
//  Created by Developer on 7/11/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountriesSelectorSingleView.h"
#import "CHAvatarView.h"

#define kSingleCountry
@implementation CDCountriesSelectorSingleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        
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
    NSMutableArray *btns = [NSMutableArray new];
    int i = 0;
    int j = 1;
    for (NSDictionary *dic in _countriesInfo) {
        if (i % 2 != 0) {
            CDCountryAvatarAndNameButton *country = [[CDCountryAvatarAndNameButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width + countrySizeWidth,
                                                                                   [[UIScreen mainScreen] bounds].size.height + countrySizeHeight,
                                                                                   countrySizeWidth,
                                                                                   countrySizeHeight)];
            
            country.delegate = self;
            
            country.data = dic;
            //country.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[dic objectForKey:@"name_en"] lowercaseString]]];
          //  [country setBackgroundColor:[UIColor clearColor]];
            [self addSubview:country];
            [self animateViewEntryFor:j forView:country andIsLeft:NO];
            j++;
            [btns addObject:country];
        } else {
            CDCountryAvatarAndNameButton *country = [[CDCountryAvatarAndNameButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width + countrySizeWidth,
                                                                                   [[UIScreen mainScreen] bounds].size.height + countrySizeHeight,
                                                                                   countrySizeWidth,
                                                                                   countrySizeHeight)];
            country.delegate = self;
            country.data = dic;
            //country.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[dic objectForKey:@"name_en"] lowercaseString]]];
            [country setBackgroundColor:[UIColor clearColor]];
            [self addSubview:country];
            [self animateViewEntryFor:j forView:country andIsLeft:YES];
            [btns addObject:country];

        }
        i++;


    }
    _myBtns = btns;
}

-(void)animateViewEntryFor:(int)j forView:(CDCountryAvatarAndNameButton *)view andIsLeft:(BOOL)isLeft
{
    if (isLeft) {
        [UIView animateWithDuration:.15 animations:^{
            [view setFrame:CGRectMake(leftX, (leftY * j)+(countrySizeHeight*(j - 1)), countrySizeWidth, countrySizeHeight)];
        }];

    } else {
        [UIView animateWithDuration:.15 animations:^{
            [view setFrame:CGRectMake(rightX, (rightY * j)+(countrySizeHeight*(j - 1)), countrySizeWidth, countrySizeHeight)];
        }];
    }
}

-(void)clickedInButtonWithCountryID:(NSString *)countryID
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kJumpToCountry object:countryID];
}


@end
