//
//  SKTwitterMediaViewRectangleStyle.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumMediaViewRectangleStyle.h"

@interface SKTwitterAlbumMediaViewRectangleStyle ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation SKTwitterAlbumMediaViewRectangleStyle

- (void)updateProgress:(float)progress
{
    self.progressView.progress = progress;
}

- (void)setProgressViewVisible:(BOOL)visible
{
    self.progressView.hidden = !visible;
}

- (void)setMediaNameAttributedText:(NSAttributedString *)nameAttributedText
{
    self.titleLabel.attributedText = nameAttributedText;
}

- (void)setMediaSizeAttributedText:(NSAttributedString *)sizeAttributedText
{
    self.subtitleLabel.attributedText = sizeAttributedText;
}

@end
