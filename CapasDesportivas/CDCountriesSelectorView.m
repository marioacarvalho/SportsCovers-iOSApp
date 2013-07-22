//
//  CDCountriesSelectorView.m
//  CapasDesportivas
//
//  Created by Developer on 7/10/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountriesSelectorView.h"
#import "MHFacebookImageViewer.h"
#import <QuartzCore/QuartzCore.h>
#import "UIFont+UIFont_CustomSystemFont.h"
#import "CDMainCoverView.h"


@implementation CDCountriesSelectorView
{
    UITapGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
    UIImageView *imageView;
    NSArray *_myArray;
    int currentPage;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    currentPage = 0;
    UIView *background = [[UIView alloc] initWithFrame:rect];
    [background setBackgroundColor:[UIColor blackColor]];
    [background setAlpha:0.4f];
    [self addSubview:background];

    
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self setupScrollView];

    /**/
    
    self.scrollView.delegate = self;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    // 4
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // 5
    [self loadVisiblePages];
    [self addSubview:_scrollView];
    


}



- (void)setupScrollView
{
    
    
    [_scrollView setPagingEnabled:YES];
    
    self.pageImages = [self setupPagesForAllCountries];
    
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

- (NSArray *)setupPagesForAllCountries
{
    NSMutableArray *mutArray = [NSMutableArray new];
    NSMutableArray *allData = [NSMutableArray new];
    NSMutableArray *tmpStack = [NSMutableArray new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    links = [self removeDuplicatedCountries:links];
    int i = 0;
    int z = 0;
    for (NSDictionary *newspaper in links) {
        [allData addObject:newspaper];
        [tmpStack addObject:newspaper];
        i++;
        if ((i % 6 == 0 && i != 0) || [links count] - i == 0) {
            CDCountriesSelectorSingleView *countrieSingleView = [[CDCountriesSelectorSingleView alloc] initWithFrame:CGRectMake(0, 0, kSupporterWidth, kSupporterHeight)];
            countrieSingleView.countriesInfo = [[NSArray alloc] initWithArray:tmpStack];
            [mutArray addObject:countrieSingleView];
            tmpStack = [NSMutableArray new];
            countrieSingleView.userInteractionEnabled = YES;
        }

                
    }
    _myArray = allData;
    _countriesView.pageViews = links;
    return mutArray;
    
    
}

- (NSArray *)removeDuplicatedCountries:(NSArray *)array
{
    NSMutableArray *newCountriesArray = [NSMutableArray new];
    for (NSDictionary *countrie in array) {
        if ([newCountriesArray lastObject]) {
            NSDictionary *dic = [newCountriesArray lastObject];
                if (![[countrie objectForKey:@"id"] isEqualToString:[dic objectForKey:@"id"]]) {
                    [newCountriesArray addObject:countrie];
                }
        } else {
            [newCountriesArray addObject:countrie];

        }
    }
    return newCountriesArray;
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
        CGRect frame = self.scrollView.bounds;
        frame.origin.y = 0.0f;
        frame.origin.x = frame.size.width * page;
        
        // 3
        CDCountriesSelectorSingleView *NewView = (CDCountriesSelectorSingleView *)[self.pageImages objectAtIndex:page];
        [NewView setFrame:CGRectMake(frame.origin.x, frame.origin.y, kSupporterWidth, kSupporterHeight)];
        [self.scrollView addSubview:NewView];
        // 4
        [self.pageViews replaceObjectAtIndex:page withObject:NewView];
    }
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
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
