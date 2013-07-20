//
//  CDCountriesScrollView.h
//  SportsCovers
//
//  Created by Developer on 7/18/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCountriesScrollView : UIScrollView<UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)info;

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
