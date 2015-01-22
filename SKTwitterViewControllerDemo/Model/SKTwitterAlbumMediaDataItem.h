//
//  SKTwitterAlbumMediaDataItem.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKTwitterAlbumMedia.h"

@interface SKTwitterAlbumMediaDataItem : NSObject <SKTwitterAlbumMedia>

@property (nonatomic, assign) CGSize mediaDisplaySize;

@property (nonatomic, assign) SKMessageMediaState mediaState;

@property (nonatomic, copy) NSProgress *mediaProgress;

@property (nonatomic, copy, readonly) NSAttributedString *mediaNameAttributedText;

@property (nonatomic, copy, readonly) NSAttributedString *mediaSizeAttributedText;

- (instancetype)initWithMediaDisplaySize:(CGSize)mediaDisplaySize
                              mediaState:(SKMessageMediaState)mediaState
                 mediaNameAttributedText:(NSAttributedString *)mediaNameAttributedText
                 mediaSizeAttributedText:(NSAttributedString *)mediaSizeAttributedText;

@end
