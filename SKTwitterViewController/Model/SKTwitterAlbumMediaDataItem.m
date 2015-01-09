//
//  SKTwitterAlbumMediaDataItem.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumMediaDataItem.h"

@implementation SKTwitterAlbumMediaDataItem

- (BOOL)shouldShowMediaTextInfoForMediaState:(SKMessageMediaState)mediaState
{
    // for subclass override
    return YES;
}

- (NSAttributedString *)mediaDescriptionForMediaState:(SKMessageMediaState)mediaState
{
    NSString *description = nil;
    
    switch (mediaState) {
        case SKMessageMediaStateDownloading: {
            description = @"Downloading...";
        } break;
        case SKMessageMediaStateUploading: {
            description = @"Uploading...";
        } break;
        case SKMessageMediaStateDownloadingFailure: {
            description = @"Downloading failure, try again";
        } break;
        case SKMessageMediaStateUploadingFailure: {
            description = @"Uploading failure, try again";
        } break;
        default:
            break;
    }
    
    return description ?
        [[NSAttributedString alloc] initWithString:description
                                        attributes:@{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:16.0f]
                                                     }] :
        nil;
}

- (instancetype)initWithMediaState:(SKMessageMediaState)mediaState
           mediaNameAttributedText:(NSAttributedString *)mediaNameAttributedText
           mediaSizeAttributedText:(NSAttributedString *)mediaSizeAttributedText
{
    NSParameterAssert([mediaNameAttributedText length]);
    NSParameterAssert([mediaSizeAttributedText length]);
    
    if (self = [super init]) {
        _mediaState = mediaState;
        _mediaProgress = [[NSProgress alloc] init];
        _mediaNameAttributedText = [mediaNameAttributedText copy];
        _mediaSizeAttributedText = [mediaSizeAttributedText copy];
    }
    return self;
}

@end
