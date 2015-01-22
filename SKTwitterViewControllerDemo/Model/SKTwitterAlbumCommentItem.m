//
//  SKTwitterAlbumCommentItem.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumCommentItem.h"

@implementation SKTwitterAlbumCommentItem

- (instancetype)initWithUserName:(NSString *)username date:(NSDate *)date replyCount:(NSUInteger)replyCount attributedText:(NSAttributedString *)attributedText mediaSections:(NSArray *)mediaSections
{
    NSAssert(NO, @"This is not the intended constructor, call %@ instead", NSStringFromSelector(@selector(initWithUserName:dateText:attributedText:)));
    return nil;
}

- (instancetype)initWithUserName:(NSString *)username
                        dateText:(NSString *)dateText
                  attributedText:(NSAttributedString *)attributedText
{
    NSParameterAssert([attributedText length]);
    
    if (self = [super initWithUserName:username dateText:dateText replyButtonText:@"reply" attributedText:attributedText mediaSections:nil]) {
        // TODO:
    }
    return self;
}

- (BOOL)shouldContentIndent
{
    return YES;
}

@end
