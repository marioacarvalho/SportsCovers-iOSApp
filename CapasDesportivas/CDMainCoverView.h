//
//  CDMainCoverView.h
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>


@interface CDMainCoverView : UIView

- (id)init;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *cover;
@property (nonatomic, strong) NSString *coverURL;

@end
