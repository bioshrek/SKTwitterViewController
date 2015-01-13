//
//  SKUserInfo.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/9/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKTwitterAlbumMedia.h"

@protocol SKTwitterAlbum <NSObject>

- (NSString *)userName;

- (NSString *)dateText;

- (NSString *)replyButtonText;

- (NSAttributedString *)attributedText;

- (BOOL)shouldContentIndent;

@end
