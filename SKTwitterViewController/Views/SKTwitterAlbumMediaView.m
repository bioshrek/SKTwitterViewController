//
//  SKTwitterAlbumMediaView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumMediaView.h"


@interface SKTwitterAlbumMediaView ()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailView;

@end

@implementation SKTwitterAlbumMediaView

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.thumbnailView.image = nil;
    [self updateProgress:0.0f];
}

#pragma mark - action

- (void)updateProgress:(float)progress
{
    NSAssert(NO, @"subclass is required to override this methond");
}

- (void)setProgressViewVisible:(BOOL)visible
{
    NSAssert(NO, @"subclass is required to override this methond");
}

- (void)setMediaNameAttributedText:(NSAttributedString *)nameAttributedText
{
    NSAssert(NO, @"subclass is required to override this methond");
}

- (void)setMediaSizeAttributedText:(NSAttributedString *)sizeAttributedText
{
    NSAssert(NO, @"subclass is required to override this methond");
}

@end
