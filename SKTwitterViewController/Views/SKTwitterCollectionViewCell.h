//
//  SKTwitterCollectionViewCell.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKTwitterMediaCollectionView.h"

@interface SKTwitterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) UIImageView *avatorImageView;
@property (weak, nonatomic, readonly) UILabel *nameLabel;
@property (weak, nonatomic, readonly) UILabel *dateTimeLabel;
@property (weak, nonatomic, readonly) UIButton *replyButton;
@property (weak, nonatomic, readonly) NSLayoutConstraint *UserInfoHolderViewHeightConstraint;

@property (weak, nonatomic, readonly) UITextView *textView;
@property (weak, nonatomic, readonly) NSLayoutConstraint *textViewHeightConstraint;

@property (weak, nonatomic, readonly) UICollectionReusableView *mediaCollectionHolderView;
@property (weak, nonatomic, readonly) NSLayoutConstraint *mediaCollectionHolderViewHeightConstraint;
@property (weak, nonatomic) SKTwitterMediaCollectionView *mediaCollectionView;

/**
 *  Returns the `UINib` object initialized for the cell.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify a reusable cell for text message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)cellReuseIdentifier;

@end
