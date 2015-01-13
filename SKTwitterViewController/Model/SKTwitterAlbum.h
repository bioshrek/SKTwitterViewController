//
//  SKUserInfo.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKTwitterAlbumMedia.h"

@protocol SKTwitterAlbum <NSObject>

- (NSString *)userName;
- (NSDate *)date;
- (NSUInteger)replyCount;

- (NSAttributedString *)attributedText;

// number of media items

- (NSInteger)numberOfMediaSections;

@optional

- (NSInteger)numberOfMediaInSection:(NSInteger)section;

- (id<SKTwitterAlbumMedia>)albumMediaForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
