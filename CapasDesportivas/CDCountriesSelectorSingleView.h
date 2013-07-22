//
//  CDCountriesSelectorSingleView.h
//  CapasDesportivas
//
//  Created by Developer on 7/11/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

@protocol CDCountriesSelectorSingleViewDelegate <NSObject>
@required
-(void)clickedToJumpCountryID:(NSString *)countryID;

@end
#import <UIKit/UIKit.h>
#import "CDCountryAvatarAndNameButton.h"

#define leftX   20
#define leftY   17

#define rightX  180
#define rightY  17

#define marginX 20

#define countrySizeWidth 120
#define countrySizeHeight 85


@interface CDCountriesSelectorSingleView : UIView<CDCountryAvatarAndNameButtonDelegate>

@property (nonatomic, strong) NSArray *myBtns;
@property (nonatomic, strong) NSArray *countriesInfo;
@property (nonatomic, weak) id <CDCountriesSelectorSingleViewDelegate> delegate;
- (void)addCountries;

@end
