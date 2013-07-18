//
//  CDVerticalPaginatedScrollView.m
//  SportsCovers
//
//  Created by Developer on 7/17/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDVerticalPaginatedScrollView.h"
#import "MHFacebookImageViewer.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CDVerticalPaginatedScrollView
{
    NSArray *_scrollViewData;
}
- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollViewData = info;
         [self setupScrollView];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
     [self setBackgroundColor:[UIColor clearColor]];
    CGSize pagesScrollViewSize = self.frame.size;
    self.contentSize = CGSizeMake(pagesScrollViewSize.width, pagesScrollViewSize.height * self.pageImages.count);
    [self setPagingEnabled:YES];
    // 5
    [self loadVisiblePages];

}


- (void)viewDidLoad
{

    
    
    /**/
    
   
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)setupScrollView
{
    
    
    
    self.pageImages = [self setupPagesForSelectedCountry];
    
    NSInteger pageCount = self.pageImages.count;
    
    // 2
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    // 3
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
}

- (NSArray *)setupPagesForSelectedCountry
{
    NSMutableArray *mutArray = [NSMutableArray new];

    NSArray *links = _scrollViewData;

    for (NSDictionary *newspaper in links) {
        

            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:[newspaper valueForKey:@"coverURL"]]];
            [image setupImageViewer];
            [mutArray addObject:image];
    
        
    }
    return mutArray;
    
    
}


- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    
    // 1
    UIImageView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        // 2
               
        CGRect frame = self.bounds;
        frame.origin.x = 0.0f;
        frame.origin.y = frame.size.height * page;
        
        // 3
        UIImageView *NewView = (UIImageView *)[self.pageImages objectAtIndex:page];
        [NewView setFrame:CGRectMake(frame.origin.x, frame.origin.y, kCoverSupporterWidth, kCoverSupporterHeight)];
        [self addSubview:NewView];
        // 4
        [self.pageViews replaceObjectAtIndex:page withObject:NewView];
    }
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageHeight = self.frame.size.height;
    NSInteger page = (NSInteger)floor((self.contentOffset.y * 2.0f + pageHeight) / (pageHeight * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    

    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
    
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}


@end
