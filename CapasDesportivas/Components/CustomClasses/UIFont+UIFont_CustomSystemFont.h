//
//  UIFont+UIFont_CustomSystemFont.h
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

@interface UIFont (CustomSystemFont)

+ (UIFont *)_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)_boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)_italicSystemFontOfSize:(CGFloat)fontSize;

@end
