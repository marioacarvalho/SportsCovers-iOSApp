//
//  UIFont+UIFont_CustomSystemFont.m
//  CapasDesportivas
//
//  Created by Developer on 7/7/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "UIFont+UIFont_CustomSystemFont.h"

@implementation UIFont(CustomSystemFont)

+ (void)load
{
    Method orig = class_getClassMethod([UIFont class], @selector(systemFontOfSize:));
    Method swiz = class_getClassMethod([UIFont class], @selector(_systemFontOfSize:));
    method_exchangeImplementations(orig, swiz);
    
    orig = class_getClassMethod([UIFont class], @selector(boldSystemFontOfSize:));
    swiz = class_getClassMethod([UIFont class], @selector(_boldSystemFontOfSize:));
    method_exchangeImplementations(orig, swiz);
    
    orig = class_getClassMethod([UIFont class], @selector(italicSystemFontOfSize:));
    swiz = class_getClassMethod([UIFont class], @selector(_italicSystemFontOfSize:));
    method_exchangeImplementations(orig, swiz);
}

+ (UIFont *)_systemFontOfSize:(CGFloat)fontSize
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
    {
        //Call original implementation.
        return [self _systemFontOfSize:fontSize];
    }
    
    return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
}

+ (UIFont *)_boldSystemFontOfSize:(CGFloat)fontSize
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
    {
        //Call original implementation.
        return [self _systemFontOfSize:fontSize];
    }
    
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
}

+ (UIFont *)_italicSystemFontOfSize:(CGFloat)fontSize
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
    {
        //Call original implementation.
        return [self _systemFontOfSize:fontSize];
    }
    
    return [UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:fontSize];
}
@end
