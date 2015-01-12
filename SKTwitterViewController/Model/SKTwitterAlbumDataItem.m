//
//  SKTwitterAlbumDataItem.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumDataItem.h"

@interface SKTwitterAlbumDataItem ()

@property (nonatomic, strong) NSArray *mediaItems;

@end

@implementation SKTwitterAlbumDataItem

- (instancetype)initWithUseName:(NSString *)username
                           date:(NSDate *)date
                     replyCount:(NSUInteger)replyCount
                 attributedText:(NSAttributedString *)attributedText
                     mediaItems:(NSArray *)mediaItems
{
    NSParameterAssert([username length]);
    NSParameterAssert(nil != date);
    
    if (self = [super init]) {
        _userName = [username copy];
        _date = [date copy];
        _replyCount = replyCount;
        _attributedText = [attributedText copy];
        _mediaItems = mediaItems;
    }
    return self;
}

#pragma mark - SKTwitterAlbum

- (NSInteger)numberOfMediaItems
{
    return [self.mediaItems count];
}

- (id<SKTwitterAlbumMedia>)albumMediaForItemAtIndex:(NSInteger)index
{
    id<SKTwitterAlbumMedia> media = nil;
    
    media = [self.mediaItems objectAtIndex:index];
    
    return media;
}




@end
