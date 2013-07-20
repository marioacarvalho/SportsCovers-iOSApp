//
//  CDCountryNameAndNewsPaperNameView.m
//  SportsCovers
//
//  Created by Developer on 7/18/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCountryNameAndNewsPaperNameView.h"

#define kCountryNameAndNewsPaperNameWidth 180
#define kCountryNameAndNewsPaperNameHeight 75


@implementation CDCountryNameAndNewsPaperNameView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

    
    _newspaperName = [[CDCustomFontLabel alloc]initWithFrame:CGRectMake(7, 0, self.frame.size.width-15, self.frame.size.height-18)];
    [_newspaperName setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [_newspaperName setText:[_options objectForKey:@"name"]];
    [_newspaperName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_newspaperName];
    
    
}


@end
