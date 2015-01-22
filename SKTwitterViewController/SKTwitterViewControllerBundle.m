//
//  SKTwitterViewControllerBundle.m
//  SKTwitterViewController
//
//  Created by Shrek Wang on 1/22/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterViewControllerBundle.h"

NSString * const SKTwitterViewControllerBundleName = @"SKTwitterViewController";

NSBundle *_instance = nil;

@implementation SKTwitterViewControllerBundle

+ (NSBundle *)sharedBundle
{
    if (!_instance) {
        NSString *bundleName = [SKTwitterViewControllerBundleName stringByAppendingPathExtension:@"bundle"];
        NSString *bundlePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:bundleName];
        _instance = [NSBundle bundleWithPath:bundlePath];
    }
    return _instance;
}

@end
