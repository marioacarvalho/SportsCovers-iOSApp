//
//  CDCountriesSelectorSingleView.h
//  CapasDesportivas
//
//  Created by Developer on 7/11/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define leftX   45
#define leftY   40

#define rightX  205
#define rightY  40

#define marginX 20

#define countrySize 70

@interface CDCountriesSelectorSingleView : UIView

@property (nonatomic, strong) NSArray *countriesInfo;
- (void)addCountries;

@end
