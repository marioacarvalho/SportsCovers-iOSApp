//
//  CDRemoteControlledBidirectionalScrollView.m
//  SportsCovers
//
//  Created by Developer on 7/18/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDRemoteControlledBidirectionalScrollView.h"
#import "CDFlagAndScrollableContentView.h"

@implementation CDRemoteControlledBidirectionalScrollView
{
    
    int _currentCollumn;
}
- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)information
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
      //  _scrollViewData = information;
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:kCountriesNeedsVerticalScroll object:nil];
    [self setBackgroundColor:[UIColor clearColor]];
    // Drawing code
    [self setupScrollView];
    _currentCollumn = 0;
    //[self setPagingEnabled:YES];
}




- (void)setupScrollView
{
    int numberOfCollumns = [self setupPagesForSelectedAllCountries];
    
    CGSize pagesScrollViewSize = self.frame.size;
    self.contentSize = CGSizeMake(pagesScrollViewSize.width* numberOfCollumns, pagesScrollViewSize.height);
    
}

- (int)setupPagesForSelectedAllCountries
{
    
    NSMutableArray *tmpCollumnArray = [NSMutableArray new];
    NSMutableArray *tmpPages = [NSMutableArray new];
    int collumn = 0;
    int row = 0;
    int tmpCountrie = 0;
    for (NSDictionary *newspaper in self.scrollViewData) {
        if (tmpCountrie == 0 || tmpCountrie == [[newspaper objectForKey:@"id"] intValue]) {
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            row++;
        } else if (row == [self.scrollViewData count]-1) {
            CDFlagAndScrollableContentView *newScrollView = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            [tmpPages addObject:newScrollView];
            [self addSubview:newScrollView];
            collumn++;
            tmpCollumnArray = [NSMutableArray new];
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            CDFlagAndScrollableContentView *newScrollView2 = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            [tmpPages addObject:newScrollView2];
            [self addSubview:newScrollView2];
            collumn++;
            
        }else {
            CDFlagAndScrollableContentView *newScrollView = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            [tmpPages addObject:newScrollView];
            [self addSubview:newScrollView];
            collumn++;
            tmpCollumnArray = [NSMutableArray new];
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            row++;
        }
        
        
        
    }
    self.pageImages = tmpPages;
    return collumn;
}

- (CDFlagAndScrollableContentView *)setupVerticalScrollViewForIndex:(int)collumn andInfoNewspapers:(NSArray *)arrayInfo
{
    CDFlagAndScrollableContentView *verticalScrollView = [[CDFlagAndScrollableContentView alloc] initWithFrame:CGRectMake(self.bounds.size.width*collumn, 0, self.frame.size.width, self.frame.size.height) AndWithArray:arrayInfo];
    [verticalScrollView setBackgroundColor:[UIColor clearColor]];
    return verticalScrollView;
}

-(void)goRight
{
    _currentCollumn++;
   // [self setContentOffset:bottomOffset animated:NO];
    CDFlagAndScrollableContentView *newView = [_pageImages objectAtIndex:_currentCollumn];
    [self scrollRectToVisible:CGRectMake(newView.frame.origin.x, 0, newView.frame.size.width, newView.frame.size.height) animated:YES];
}

-(void)goLeft
{
    if (_currentCollumn > 0) {
        _currentCollumn--;
        CDFlagAndScrollableContentView *newView = [_pageImages objectAtIndex:_currentCollumn];
        [self scrollRectToVisible:CGRectMake(newView.frame.origin.x, 0, newView.frame.size.width, newView.frame.size.height) animated:YES];
    }

}

- (void)goUp
{
    
}

- (void)goDown
{
    
}

-(void)didReceiveNotification:(NSNotification *)notification
{
    NSDictionary *newInfo = notification.object;
    CGFloat newContentY = [[newInfo objectForKey:@"newContentY"] floatValue];
    int index = [[newInfo objectForKey:@"currentCollumn"] intValue];

    CDFlagAndScrollableContentView *contentView = [_pageImages objectAtIndex:index];
    if ([notification.name isEqualToString:kCountriesNeedsVerticalScroll]) {
        CGFloat countriesOffsetY = (newContentY * contentView.scrollView.bounds.size.height)/kCoverSupporterHeight;
        [contentView.scrollView scrollRectToVisible:CGRectMake(0, countriesOffsetY, contentView.scrollView.frame.size.width, contentView.scrollView.frame.size.height) animated:NO];
    }
}


@end