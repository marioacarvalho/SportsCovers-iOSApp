//
//  CDCountriesSelectorView.h
//  CapasDesportivas
//
//  Created by Developer on 7/10/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCountriesControlView.h"
#import "CDCountriesSelectorSingleView.h"


@interface CDCountriesSelectorView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet CDCountriesControlView *countriesView;

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

@end
