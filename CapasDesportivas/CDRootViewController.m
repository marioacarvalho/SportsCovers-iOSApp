//
//  CDRootViewController.m
//  CapasDesportivas
//
//  Created by Developer on 7/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDRootViewController.h"
#import "MHFacebookImageViewer.h"
#import <QuartzCore/QuartzCore.h>
#import "UIFont+UIFont_CustomSystemFont.h"
#import "CDMainCoverView.h"
#import "iAd/iAd.h"
#import "CDAppDelegate.h"

@interface CDRootViewController ()
    
@end

@implementation CDRootViewController
{
    UITapGestureRecognizer *tap;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
    BOOL isFullScreen;
    CGRect prevFrame;
    UIImageView *imageView;
    NSArray *_myArray;
    int currentPage;
    BOOL countriesSelector;
    int selectedCountryID;
    NSArray *scrollViewPositions;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setBackgroundView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * whiteColor = [UIColor colorWithRed:99.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
    UIColor * lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    // UIColor * redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)whiteColor.CGColor,
                       (id)lightGrayColor.CGColor,
                       nil];
    
    // Set bounds
    gradient.frame = self.view.bounds;
    
    // Add the gradient to the view
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad
{

    
    selectedCountryID = 173;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _scrollView = [[CDBidirectionalScrollView alloc] initWithFrame:_scrollView.frame andWithArray:links];
    #ifdef FREE_VERSION
        [_iAdBanner setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _iAdBanner.delegate = self;
    #endif
    currentPage = 0;
    countriesSelector = NO;
    [self setBackgroundView];
    
   // [self setupScrollView];
    
    /**/
    [self setupGesturesForCountries];
    self.scrollView.delegate = self;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    
    [_menuBtn addTarget:MY_APPDELEGATE.deck action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];

    
    
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)setupScrollView
{
    
    
    
    self.pageImages = [self setupPagesForSelectedCountrie];
    
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

- (NSArray *)setupPagesForSelectedCountrie
{
    NSMutableArray *mutArray = [NSMutableArray new];
    NSMutableArray *allData = [NSMutableArray new];
    
    NSMutableArray *tmpAllPositions = [NSMutableArray new];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    int collumn = 1;
    int row = 1;
    int tmpCountrie = 0;
    for (NSDictionary *newspaper in links) {
        
        if (tmpCountrie == 0 || tmpCountrie == [[newspaper objectForKey:@"id"] intValue]) {
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            NSDictionary *info = @{@"countryID": [newspaper objectForKey:@"id"],
                                   @"row": [NSString stringWithFormat:@"%d", row],
                                   @"collumn": [NSString stringWithFormat:@"%d", collumn]};
            row++;
            [tmpAllPositions addObject:info];

        } else {
            collumn++;
            row = 1;
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            NSDictionary *info = @{@"countryID": [newspaper objectForKey:@"id"],
                                   @"row": [NSString stringWithFormat:@"%d", row],
                                   @"collumn": [NSString stringWithFormat:@"%d", collumn]};
            row++;
            [tmpAllPositions addObject:info];

        }
        if ([[newspaper objectForKey:@"id"] intValue] == selectedCountryID) {
            [allData addObject:newspaper];
            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:[newspaper valueForKey:@"coverURL"]]];
            [image setupImageViewer];
            [mutArray addObject:image];
        }
        
       // }
            

    }
    _myArray = allData;
    _countriesView.pageViews = links;
    scrollViewPositions = tmpAllPositions;
    return mutArray;
    
    
}

- (NSArray *)setupPagesForAllCountries_
{
    NSMutableArray *mutArray = [NSMutableArray new];
    NSMutableArray *allData = [NSMutableArray new];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    for (NSDictionary *newspaper in links) {
        
        
    }
    _myArray = allData;
    _countriesView.pageViews = links;
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
        NSDictionary *positionInformation = [scrollViewPositions objectAtIndex:page];
        
        int collumn = [[positionInformation objectForKey:@"collumn"] intValue];
        int row = [[positionInformation objectForKey:@"row"] intValue];

        CGRect frame = self.scrollView.bounds;
        frame.origin.x = 0.0f + (frame.size.width*(collumn-1));
        frame.origin.y = frame.size.height * (row-1);
        
        // 3
        UIImageView *NewView = (UIImageView *)[self.pageImages objectAtIndex:page];
        [NewView setFrame:CGRectMake(frame.origin.x, frame.origin.y, kCoverSupporterWidth, kCoverSupporterHeight)];
        [self.scrollView addSubview:NewView];
        // 4
        [self.pageViews replaceObjectAtIndex:page withObject:NewView];
    }
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageHeight = self.scrollView.frame.size.height;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.y * 2.0f + pageHeight) / (pageHeight * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;

    if (page != currentPage) {
        if (page > currentPage) {
            NSDictionary *information = [self getCountrieInfoFor:1];
            [_countriesView goForwardWithInformation:information];
        } else {
            NSDictionary *information = [self getCountrieInfoFor:0];
            [_countriesView goBackwardWithInformation:information];

        }
        currentPage = page;
    }

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

- (NSDictionary *)getCountrieInfoFor:(int)up
//if up = 1, going to right
{
    NSDictionary *dic = [NSDictionary new];
    switch (up) {
        case 0:
            if (currentPage-2 >= 0) {
                dic = [_myArray objectAtIndex:currentPage-2];
            }
            break;
        case 1:
            if ([_myArray count] > currentPage+2) {
                dic = [_myArray objectAtIndex:currentPage+2];
            }
            break;
        default:
            break;
    }
    return dic;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

-(void)setupGesturesForCountries
{
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedLeft:)];
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedRight:)];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];

    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    
    [_countriesGesturesView addGestureRecognizer:swipeLeft];
    [_countriesGesturesView addGestureRecognizer:swipeRight];
    [_countriesGesturesView addGestureRecognizer:tap];

}

-(void)swippedLeft:(UIGestureRecognizer *)recognizer
{
    NSLog(@"left");
}

-(void)swippedRight:(UIGestureRecognizer *)recognizer
{
    NSLog(@"right");
    [_scrollView goRight];
}
- (void)tapped:(UIGestureRecognizer *)recognizer {
    if (!countriesSelector) {
        if (_countriesSelectorView == nil) {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            _countriesSelectorView = [[CDCountriesSelectorView alloc] initWithFrame:CGRectMake(0, screenRect.size.height, kSupporterWidth, kSupporterHeight)];
            [self.view addSubview:_countriesSelectorView];
            [self slideInCountries];
        } else {
            [_countriesSelectorView removeFromSuperview];
            _countriesSelectorView = nil;
            [self countriesAction:nil];
        }
    } else {
        [self slideOutCountries];
    }
}

- (void)slideInCountries
{
    [UIView animateWithDuration:.15 animations:^{
        [_countriesSelectorView setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - kSupporterHeight, kSupporterWidth, kSupporterHeight)];
    } completion:^(BOOL finished) {
        if (finished) {
            for (CDCountriesSelectorSingleView *view in _countriesSelectorView.pageViews) {
                [view addCountries];
            }
        }
    }];
    countriesSelector = YES;
}

- (void)slideOutCountries
{
    [UIView animateWithDuration:.15 animations:^{
        [_countriesSelectorView setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, kSupporterWidth, kSupporterHeight)];
    } completion:^(BOOL finished) {
        [_countriesSelectorView removeFromSuperview];
        _countriesSelectorView = nil;
        countriesSelector = NO;
    }];

}

- (void)getNextCountrie
{
    BOOL found = NO;
    for (NSDictionary *countrie in scrollViewPositions) {
        if ([[countrie objectForKey:@"countryID"] intValue] == selectedCountryID) {
            found = YES;
        }
        if (found && [[countrie objectForKey:@"countryID"] intValue] != selectedCountryID) {
            NSLog(@"%@", [countrie objectForKey:@"countryID"]);
            return;
            
        }
    }
}
/*
 *
 * iAds
 *
 */
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"ok bannerView\n");

    [bannerView_ removeFromSuperview];
    bannerView_ = nil;

    _iAdBanner = banner;
    [_iAdBanner setHidden:NO];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"failed bannerView\n");

    [_iAdBanner setHidden:YES];
    [self loadADMob];
}

- (void)loadADMob
{
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    
    [bannerView_ removeFromSuperview];
    bannerView_ = nil;

    // Initialize the banner at the bottom of the screen.
    CGPoint origin = CGPointMake(0.0,
                                 self.view.frame.size.height  -
                                 CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    
    // Use predefined GADAdSize constants to define the GADBannerView.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner
                                                 origin:origin];
    // Specify the ad's "unit identifier". This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a151e5aa6893fd6";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    //[bannerView_ loadRequest:[GADRequest request]];
    
    //test
    GADRequest *request = [[GADRequest alloc] init];
   // request.testDevices = [NSArray arrayWithObjects:@"ce209cd832d2eb2b65dce2c7bf594d7a", nil];
    [bannerView_ loadRequest:request];
    
}

@end
