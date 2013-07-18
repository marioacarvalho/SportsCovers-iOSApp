//
//  CDMainCoverView.m
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDMainCoverView.h"

@implementation CDMainCoverView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kCoverSupporterWidth, kCoverSupporterHeight)];
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
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCoverSupporterWidth, kCoverSupporterHeight)];
    [_background setImage:[UIImage imageNamed:@"CoverSupporter.png"]];
    [self addSubview:_background];
    
    _cover = [[UIImageView alloc] initWithFrame:CGRectMake(kCoverX, kCoverY, kCoverWidth, kCoverHeight)];
    [_cover setImageWithURL:[NSURL URLWithString:_coverURL]];
    [self addSubview:_cover];
}


@end
