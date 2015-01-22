//
//  SKTwitterMediaViewSquareStyle.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumMediaViewSquareStyle.h"



@interface SKTwitterAlbumMediaViewSquareStyle ()

@property (weak, nonatomic) IBOutlet MRCircularProgressView *progressView;


@end

@implementation SKTwitterAlbumMediaViewSquareStyle

- (void)updateProgress:(float)progress
{
    self.progressView.progress = progress;
}

- (void)setProgressViewVisible:(BOOL)visible
{
    self.progressView.borderWidth = 1.0f;
    CGRect bounds = self.bounds;
    self.progressView.lineWidth = ceilf(CGRectGetWidth(bounds) / 2.0f);
    [self.progressView.valueLabel removeFromSuperview];
    
    self.progressView.hidden = !visible;
}

- (void)setMediaNameAttributedText:(NSAttributedString *)nameAttributedText
{
    // nothing to do
}

- (void)setMediaSizeAttributedText:(NSAttributedString *)sizeAttributedText
{
    // nothing to do
}

@end
