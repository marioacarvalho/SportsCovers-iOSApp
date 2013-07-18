//
//  CDCustomFontLabel.m
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDCustomFontLabel.h"

@implementation CDCustomFontLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if(_customFont){
        [self setFont: [UIFont fontWithName:_customFont size:self.font.pointSize]];
    }else{
        [self setFont: [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:self.font.pointSize]];

    }
}

@end
