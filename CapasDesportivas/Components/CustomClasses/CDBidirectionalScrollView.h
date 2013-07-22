//
//  CDBidirectionalScrollView.h
//  SportsCovers
//
//  Created by Developer on 7/17/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDVerticalPaginatedScrollView.h"
@interface CDBidirectionalScrollView : UIScrollView<CDVerticalPaginatedScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)information;

@property NSArray *allCountriesCollumnsAndIds;


@property (nonatomic, strong) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

-(void)scrollToCollumn:(int)collumn;
-(void)goRight;
@end
