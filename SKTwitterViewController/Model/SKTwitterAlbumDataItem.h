//
//  SKTwitterAlbumDataItem.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKTwitterAlbum.h"
#import "SKTwitterAlbumMediaDataItem.h"

@interface SKTwitterAlbumDataItem : NSObject <SKTwitterAlbum>

@property (nonatomic, copy, readonly) NSString *userName;

@property (nonatomic, copy, readonly) NSDate *date;

@property (nonatomic, assign, readonly) NSUInteger replyCount;

@property (nonatomic, copy, readonly) NSAttributedString *attributedText;

- (instancetype)initWithUseName:(NSString *)username
                           date:(NSDate *)date
                     replyCount:(NSUInteger)replyCount
                 attributedText:(NSAttributedString *)attributedText
                  mediaSections:(NSArray *)mediaSections;  // List<List<Media>>

@end
