//
//  CDVerticalPaginatedScrollView.h
//  SportsCovers
//
//  Created by Developer on 7/17/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

@protocol CDVerticalPaginatedScrollViewDelegate <NSObject>
@required
- (void)scrolledToContentOffSetY:(CGFloat)newContentY forCollumn:(int)currentCollumn;
@end
#import <UIKit/UIKit.h>

@interface CDVerticalPaginatedScrollView : UIScrollView<UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)info;
@property (nonatomic, strong) id<CDVerticalPaginatedScrollViewDelegate> scrollDelegate;
@property int collumn;
@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
