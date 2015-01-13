//
//  SKTwitterAlbumDataItem.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumDataItem.h"

@interface SKTwitterAlbumDataItem ()

@property (nonatomic, strong) NSArray *mediaSections;  // List<List<Media>>

@end

@implementation SKTwitterAlbumDataItem

- (instancetype)initWithUserName:(NSString *)username
                        dateText:(NSString *)dateText
                 replyButtonText:(NSString *)replyButtonText
                 attributedText:(NSAttributedString *)attributedText
                  mediaSections:(NSArray *)mediaSections
{
    NSParameterAssert([username length]);
    NSParameterAssert([dateText length]);
    
    if (self = [super init]) {
        _userName = [username copy];
        _dateText = [dateText copy];
        _replyButtonText = [replyButtonText copy];
        _attributedText = [attributedText copy];
        _mediaSections = mediaSections;
    }
    return self;
}

#pragma mark - SKTwitterAlbum

- (NSInteger)numberOfMediaSections
{
    return [self.mediaSections count];
}

- (NSInteger)numberOfMediaInSection:(NSInteger)section
{
    return [[self mediaSectionAtIndex:section] count];
}

- (NSArray *)mediaSectionAtIndex:(NSInteger)index
{
    return [self.mediaSections objectAtIndex:index];
}

- (id<SKTwitterAlbumMedia>)albumMediaForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SKTwitterAlbumMedia> media = nil;
    
    media = [[self mediaSectionAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    return media;
}

- (BOOL)shouldContentIndent
{
    return NO;
}



@end
