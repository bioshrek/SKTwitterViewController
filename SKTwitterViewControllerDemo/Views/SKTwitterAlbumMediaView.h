//
//  SKTwitterAlbumMediaView.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/13/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTwitterAlbumMediaView : UICollectionViewCell

@property (nonatomic, weak, readonly) UIImageView *thumbnailView;

- (void)updateProgress:(float)progress;
- (void)setProgressViewVisible:(BOOL)visible;

- (void)setMediaNameAttributedText:(NSAttributedString *)nameAttributedText;
- (void)setMediaSizeAttributedText:(NSAttributedString *)sizeAttributedText;

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;

@end
