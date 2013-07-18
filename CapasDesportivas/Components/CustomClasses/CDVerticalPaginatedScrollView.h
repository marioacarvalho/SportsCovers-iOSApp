//
//  CDVerticalPaginatedScrollView.h
//  SportsCovers
//
//  Created by Developer on 7/17/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDVerticalPaginatedScrollView : UIScrollView

- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)info;

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
