//
//  CDRootViewController.h
//  CapasDesportivas
//
//  Created by Developer on 7/5/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDRemoteControlledBidirectionalScrollView.h"
#import "CDBidirectionalScrollView.h"
#import "CDCountriesControlView.h"
#import "CDCountriesSelectorView.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import "DRNRealTimeBlurView.h"
@interface CDRootViewController : UIViewController<UIScrollViewDelegate, ADBannerViewDelegate>
{
    GADBannerView *bannerView_;

}
@property (weak, nonatomic) IBOutlet UIImageView *imageRecord;
@property (weak, nonatomic) IBOutlet UIImageView *imageAbola;
@property (weak, nonatomic) IBOutlet UIImageView *imageOJogo;

@property (weak, nonatomic) IBOutlet UIView *countriesGesturesView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn; 

@property (weak, nonatomic) IBOutlet CDCustomFontLabel *currentDayLabel;
@property (weak, nonatomic) IBOutlet CDCustomFontLabel *currentMonthLabel;
@property (strong, nonatomic) IBOutlet CDBidirectionalScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) DRNRealTimeBlurView *blurView;
@property (strong, nonatomic) CDCountriesSelectorView *countriesSelectorView;
@property (weak, nonatomic) IBOutlet ADBannerView *iAdBanner;
@property (strong, nonatomic) IBOutlet CDRemoteControlledBidirectionalScrollView *countriesBidirectionalScrollView;

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (IBAction)countriesAction:(id)sender;

@end
