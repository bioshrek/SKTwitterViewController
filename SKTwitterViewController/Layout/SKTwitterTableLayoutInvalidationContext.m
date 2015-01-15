//
//  SKTwitterTableLayoutInvalidationContext.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterTableLayoutInvalidationContext.h"

@implementation SKTwitterTableLayoutInvalidationContext

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.invalidateFlowLayoutDelegateMetrics = NO;
        self.invalidateFlowLayoutAttributes = NO;
        _emptyCache = NO;
    }
    return self;
}

@end
