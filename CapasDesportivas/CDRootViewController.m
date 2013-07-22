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

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface CDRootViewController ()

@property (nonatomic, assign) NSInteger lastContentOffsetX;
@property (nonatomic, assign) NSInteger lastContentOffsetY;


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToCountry:) name:kJumpToCountry object:nil];
    _lastContentOffsetX = 0;
    _lastContentOffsetY = 0;
    selectedCountryID = 173;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.scrollView = [[CDBidirectionalScrollView alloc] initWithFrame:_scrollView.frame andWithArray:links];
    self.countriesBidirectionalScrollView.scrollViewData = links;
    [self.countriesBidirectionalScrollView setBackgroundColor:[UIColor clearColor]];
    self.countriesBidirectionalScrollView.delegate = self;
    [self.countriesBidirectionalScrollView setNeedsDisplay];
    
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
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"MMM"];
    NSString  *x = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
;
    NSInteger day = [components day];
    [_currentDayLabel setText:[NSString stringWithFormat:@"%d", day]];
    [_currentMonthLabel setText:[x lowercaseString]];

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
          //  _blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, screenRect.size.height, kSupporterWidth, kSupporterHeight)];
         //   [self.view addSubview:_blurView];
            [self.view addSubview:_countriesSelectorView];
            [self slideInCountries];
        } else {
            [_countriesSelectorView removeFromSuperview];
            _countriesSelectorView = nil;
         //   [_blurView removeFromSuperview];
         //   _blurView = nil;
            [self countriesAction:nil];
        }
    } else {
        [self slideOutCountries];
    }
}

- (void)slideInCountries
{
    
    [UIView animateWithDuration:.15 animations:^{
        CGRect rect = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - kSupporterHeight, kSupporterWidth, kSupporterHeight);
        //[_blurView setFrame:rect];
        [_countriesSelectorView setFrame:rect];
        
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
        CGRect rect = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, kSupporterWidth, kSupporterHeight);
        [_countriesSelectorView setFrame:rect];
       // [_blurView setFrame:rect];
    } completion:^(BOOL finished) {
        [_countriesSelectorView removeFromSuperview];
        _countriesSelectorView = nil;
      //  [_blurView removeFromSuperview];
      //  _blurView = nil;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat countriesOffsetX = (scrollView.contentOffset.x * _countriesBidirectionalScrollView.bounds.size.width)/scrollView.bounds.size.width;
    NSLog(@"%f\n", countriesOffsetX);
    [_countriesBidirectionalScrollView scrollRectToVisible:CGRectMake(countriesOffsetX, 0, _countriesBidirectionalScrollView.frame.size.width, _countriesBidirectionalScrollView.frame.size.height) animated:NO];
    //self.scrollView = (CDBidirectionalScrollView *)scrollView;
}

-(void)jumpToCountry:(NSNotification *)notification
{

    int collumn = [self countryCollumnForID:notification.object];
    if (collumn != -1) {
        CDVerticalPaginatedScrollView *verticalSV = [self viewForCollumn:collumn];
        if (verticalSV != nil) {
            [self slideOutCountries];
            [self.scrollView setContentOffset:verticalSV.frame.origin animated:YES];
        }
        
    } else {
#warning NEEDS USER ID
        [TestFlight passCheckpoint:@"error jump to country"];
        [self slideOutCountries];
    }
}

-(int)countryCollumnForID:(NSString *)countryID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults objectForKey:kAllCountriesIdsAndCollumnsRelation];
    for (NSDictionary *dic in array) {
        if ([[dic objectForKey:@"id"] isEqualToString:countryID]) {
            return [[dic objectForKey:@"collumn"] intValue];
        }
    }
    return -1;
}

-(CDVerticalPaginatedScrollView *)viewForCollumn:(int)collumn
{
    for (UIView *theview in self.view.subviews) {
        if ([theview isKindOfClass:[CDBidirectionalScrollView class]]) {
            self.scrollView = (CDBidirectionalScrollView *)theview;
            return [[theview subviews] objectAtIndex:collumn-1];
        }
    }
    return nil;
}

@end
