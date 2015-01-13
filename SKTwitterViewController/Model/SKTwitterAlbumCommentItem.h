//
//  SKTwitterAlbumCommentItem.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterAlbumDataItem.h"

@interface SKTwitterAlbumCommentItem : SKTwitterAlbumDataItem

- (instancetype)initWithUserName:(NSString *)username
                        dateText:(NSString *)dateText
                  attributedText:(NSAttributedString *)attributedText;

@end
