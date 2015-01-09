//
//  SKTwitterAlbumMedia.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SKMessageMediaState) {
    SKMessageMediaStateDraft = 1,
    SKMessageMediaStateUploading = 2,
    SKMessageMediaStateUploadingFailure = 3,
    SKMessageMediaStateUploaded = 4,
    SKMessageMediaStateToBeDownloaded = 5,
    SKMessageMediaStateDownloading = 6,
    SKMessageMediaStateDownloadingFailure = 7,
    SKMessageMediaStateDownloaded = 8,
    SKMessageMediaStateReviewed = 9,
};

@protocol SKTwitterAlbumMedia <NSObject>

// media message state
- (SKMessageMediaState)mediaState;
- (void)setMediaState:(SKMessageMediaState)mediaState;

// media message progress
- (NSProgress *)mediaProgress;
- (void)setMediaProgress:(NSProgress *)progress;

// media title
- (NSAttributedString *)mediaNameAttributedText;

// media size
- (NSAttributedString *)mediaSizeAttributedText;

// should show media title, size for states
- (BOOL)shouldShowMediaTextInfoForMediaState:(SKMessageMediaState)mediaState;

// media description for states
- (NSAttributedString *)mediaDescriptionForMediaState:(SKMessageMediaState)mediaState;

@end
