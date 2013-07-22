//
//  CDBidirectionalScrollView.m
//  SportsCovers
//
//  Created by Developer on 7/17/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDBidirectionalScrollView.h"



@implementation CDBidirectionalScrollView
{
    NSArray *_scrollViewData;
    int _currentCollumn;
    NSArray *pageImages;
}


- (id)initWithFrame:(CGRect)frame andWithArray:(NSArray *)information
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    _currentCollumn = 0;
    [self setPagingEnabled:YES];
    // Drawing code
    [self setupScrollView];

}


- (void)viewDidLoad
{
    
    [self setupScrollView];
    
    /**/
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{

    
    
}

- (void)setupScrollView
{
    int numberOfCollumns = [self setupPagesForSelectedAllCountries];
    
    CGSize pagesScrollViewSize = self.frame.size;
    self.contentSize = CGSizeMake(pagesScrollViewSize.width* numberOfCollumns, pagesScrollViewSize.height);

}

- (int)setupPagesForSelectedAllCountries
{
    NSMutableArray *tmpPages = [NSMutableArray new];

    NSMutableArray *tmpCollumnArray = [NSMutableArray new];
    NSMutableArray *countriesCollumnsAndIds = [NSMutableArray new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kApplicationLinks];
    NSArray *links = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    int collumn = 0;
    int row = 0;
    int tmpCountrie = 0;
    for (NSDictionary *newspaper in links) {
        if (tmpCountrie == 0 || tmpCountrie == [[newspaper objectForKey:@"id"] intValue]) {
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            row++;
        } else if (row == [links count]-1) {
            CDVerticalPaginatedScrollView *newScrollView = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            newScrollView.collumn = collumn;
            newScrollView.scrollDelegate = self;
            [tmpPages addObject:newScrollView];
            [self addSubview:newScrollView];
            collumn++;
            NSDictionary *dic = @{@"id": [NSString stringWithFormat:@"%d", tmpCountrie ],
                                  @"collumn": [NSString stringWithFormat:@"%d", collumn]};
            [countriesCollumnsAndIds addObject:dic];
            tmpCollumnArray = [NSMutableArray new];
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            CDVerticalPaginatedScrollView *newScrollView2 = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            newScrollView2.collumn = collumn;
            newScrollView2.scrollDelegate = self;
            [tmpPages addObject:newScrollView2];
            [self addSubview:newScrollView2];
            collumn++;
            NSDictionary *dic2 = @{@"id": [NSString stringWithFormat:@"%d", tmpCountrie ],
                                  @"collumn": [NSString stringWithFormat:@"%d", collumn]};
            [countriesCollumnsAndIds addObject:dic2];
            
        }else {
            CDVerticalPaginatedScrollView *newScrollView = [self setupVerticalScrollViewForIndex:collumn andInfoNewspapers:tmpCollumnArray];
            newScrollView.collumn = collumn;
            newScrollView.scrollDelegate = self;
            [tmpPages addObject:newScrollView];
            [self addSubview:newScrollView];
            collumn++;
            NSDictionary *dic = @{@"id": [NSString stringWithFormat:@"%d", tmpCountrie ],
                                  @"collumn": [NSString stringWithFormat:@"%d", collumn]};
            [countriesCollumnsAndIds addObject:dic];
            tmpCollumnArray = [NSMutableArray new];
            [tmpCollumnArray addObject:newspaper];
            tmpCountrie = [[newspaper objectForKey:@"id"] intValue];
            row++;
        }

        
        
    }
    [defaults setObject:countriesCollumnsAndIds forKey:kAllCountriesIdsAndCollumnsRelation];
    [defaults synchronize];
    pageImages = tmpPages;
    return collumn;
}

- (CDVerticalPaginatedScrollView *)setupVerticalScrollViewForIndex:(int)collumn andInfoNewspapers:(NSArray *)arrayInfo
{
    CDVerticalPaginatedScrollView *verticalScrollView = [[CDVerticalPaginatedScrollView alloc] initWithFrame:CGRectMake(self.bounds.size.width*collumn,
                                                                                                                        0, self.frame.size.width,
                                                                                                                        self.frame.size.height)
                                                                                                andWithArray:arrayInfo];
    return verticalScrollView;
}

-(void)scrolledToContentOffSetY:(CGFloat)newContentY forCollumn:(int)currentCollumn
{
    NSDictionary *info = @{@"newContentY": [NSString stringWithFormat:@"%f", newContentY],
                           @"currentCollumn":[NSString stringWithFormat:@"%d", currentCollumn]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kCountriesNeedsVerticalScroll object:info];
}

-(void)scrollToCollumn:(int)collumn
{
    CDVerticalPaginatedScrollView *jumpPage = (CDVerticalPaginatedScrollView *)[self.subviews objectAtIndex:collumn-1];
    [self scrollRectToVisible:jumpPage.frame animated:YES];
}

@end
