//
//  CDCountriesControlView.h
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCountriesControlView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *pageViews;
@property int selectedCountrieID;

@property (strong, nonatomic) UIScrollView *scrollView;

- (void)goForwardWithInformation:(NSDictionary *)dictionary;
- (void)goBackwardWithInformation:(NSDictionary *)dictionary;

@end
