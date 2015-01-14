//
//  SKTwitterCollectionViewCell.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTwitterCollectionViewCell;
#import "SKTwitterMediaCollectionView.h"

#pragma mark - SKTwitterCollectionViewCell Delegate

@protocol SKTwitterCollectionViewCellDelegate <NSObject>

- (void)didSelectAvatorButtonInCollectionViewCell:(SKTwitterCollectionViewCell *)cell;

- (void)didSelectReplyButtonInCollectionViewCell:(SKTwitterCollectionViewCell *)cell;

@end


#pragma mark - layout constants

extern CGFloat const kSKTwitterCollectionViewCellUserInfoHolderViewHeight;
extern CGFloat const kSKTwitterCollectionViewCellMarginTopSpacing;
extern CGFloat const kSKTwitterCollectionViewCellMarginLeftSpacing;
extern CGFloat const kSKTwitterCollectionViewCellMarginBottomSpacing;
extern CGFloat const kSKTwitterCollectionViewCellMarginRightSpacing;
extern CGFloat const kSKTwitterCollectionViewCellAvatorImageWidth;

@interface SKTwitterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) UIButton *avatorButton;
@property (weak, nonatomic, readonly) UILabel *nameLabel;
@property (weak, nonatomic, readonly) UILabel *dateTimeLabel;
@property (weak, nonatomic, readonly) UIButton *replyButton;
@property (weak, nonatomic, readonly) NSLayoutConstraint *UserInfoHolderViewHeightConstraint;

@property (weak, nonatomic, readonly) UILabel *textLabel;
@property (weak, nonatomic, readonly) NSLayoutConstraint *textLabelHeightConstraint;

@property (weak, nonatomic, readonly) NSLayoutConstraint *mediaCollectionViewHeightConstraint;
@property (weak, nonatomic, readonly) SKTwitterMediaCollectionView *mediaCollectionView;

@property (copy, nonatomic) NSIndexPath *albumIndexPath;
@property (weak, nonatomic) id<SKTwitterCollectionViewCellDelegate> delegate;

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



