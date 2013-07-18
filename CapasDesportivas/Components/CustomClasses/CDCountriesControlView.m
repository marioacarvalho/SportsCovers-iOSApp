//
//  CDCountriesControlView.m
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountriesControlView.h"
#import "CDCountrieView.h"
@implementation CDCountriesControlView
{
    NSMutableArray *views;
}
- (void)awakeFromNib
{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kCountrieViewWidth, kCountrieViewHeight)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    
    // Drawing code
    int i = 0;
    if (_pageViews) {
        for (NSDictionary *countries in _pageViews) {
            CDCountrieView *countryView = [[CDCountrieView alloc] init];
            [countryView setFrame:CGRectMake(0, 0+(kCountrieViewHeight *i), kCountrieViewWidth, kCountrieViewHeight)];
            countryView.options = countries;
            [views addObject:countryView];
            [_scrollView addSubview:countryView];
            i++;
        }
        CGSize pagesScrollViewSize = _scrollView.frame.size;
        self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width, pagesScrollViewSize.height * [_pageViews count]);
        _scrollView.contentOffset = CGPointMake(0,0);
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        [self addSubview:_scrollView];


    }
    
    
}

- (void)goForwardWithInformation:(NSDictionary *)dictionary
{
    CGPoint currentOffset = _scrollView.contentOffset;
    [UIView animateWithDuration:.25 animations:^{
        [_scrollView setContentOffset:CGPointMake(0, currentOffset.y + kCountrieViewHeight)];
    }];
}

- (void)goBackwardWithInformation:(NSDictionary *)dictionary
{
    CGPoint currentOffset = _scrollView.contentOffset;

    [UIView animateWithDuration:.25 animations:^{
        [_scrollView setContentOffset:CGPointMake(0, currentOffset.y - kCountrieViewHeight)];
    }];

    
}

- (void)goLeftWithInformation:(NSDictionary *)dictionary
{
    CGPoint currentOffset = _scrollView.contentOffset;
    [UIView animateWithDuration:.25 animations:^{
        [_scrollView setContentOffset:CGPointMake(0, currentOffset.y + kCountrieViewHeight)];
    }];
}

- (void)goRightWithInformation:(NSDictionary *)dictionary
{
    CGPoint currentOffset = _scrollView.contentOffset;
    
    [UIView animateWithDuration:.25 animations:^{
        [_scrollView setContentOffset:CGPointMake(0, currentOffset.y - kCountrieViewHeight)];
    }];
    
    
}


@end
