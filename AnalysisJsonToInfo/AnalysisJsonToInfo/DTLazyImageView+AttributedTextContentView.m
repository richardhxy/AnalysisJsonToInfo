//
//  DTLazyImageView+AttributedTextContentView.m
//  zhixue
//
//  Created by iflytek on 15/5/12.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "DTLazyImageView+AttributedTextContentView.h"
#import <objc/runtime.h>

static const void *AttributedTextContentView = &AttributedTextContentView;

@implementation DTLazyImageView (AttributedTextContentView)

- (void)setAttributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView
{
    objc_setAssociatedObject(self, AttributedTextContentView, attributedTextContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DTAttributedTextContentView *)attributedTextContentView
{
    return objc_getAssociatedObject(self, AttributedTextContentView);
}

@end
