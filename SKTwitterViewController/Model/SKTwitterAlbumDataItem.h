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

@property (nonatomic, copy, readonly) NSString *dateText;

@property (nonatomic, copy, readonly) NSString *replyButtonText;

@property (nonatomic, copy, readonly) NSAttributedString *attributedText;

- (instancetype)initWithUserName:(NSString *)username
                        dateText:(NSString *)dateText
                 replyButtonText:(NSString *)replyButtonText
                  attributedText:(NSAttributedString *)attributedText
                   mediaSections:(NSArray *)mediaSections;  // List<List<Media>>

@end
