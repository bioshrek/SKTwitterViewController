//
//  SKTwitterCollectionViewCell.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionViewCell.h"

#import "SKTwitterTableLayoutAttributes.h"

#import "SKTwitterMediaView.h"

#pragma mark - layout constants

CGFloat const kSKTwitterCollectionViewCellUserInfoHolderViewHeight = 44.0f;
CGFloat const kSKTwitterCollectionViewCellMarginTopSpacing = 8.0f;
CGFloat const kSKTwitterCollectionViewCellMarginLeftSpacing = 8.0f;
CGFloat const kSKTwitterCollectionViewCellMarginBottomSpacing = 8.0f;
CGFloat const kSKTwitterCollectionViewCellMarginRightSpacing = 8.0f;
CGFloat const kSKTwitterCollectionViewCellAvatorImageWidth = 44.0f;

@interface SKTwitterCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *avatorButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UserInfoHolderViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatorImageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userInfoHolderViewMarginLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView_NameLabel_HorizontalSpacingConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelMarginLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelVerticalSpacing;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaCollectionViewMarginLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaCollectionViewVerticalSpacing;
@property (weak, nonatomic) IBOutlet SKTwitterMediaCollectionView *mediaCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaCollectionViewHeightConstraint;

@end

@implementation SKTwitterCollectionViewCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark - life cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // TODO: 
}

- (void)setAlbumIndexPath:(NSIndexPath *)albumIndexPath
{
    _albumIndexPath = [albumIndexPath copy];
    
    self.mediaCollectionView.albumIndexPath = albumIndexPath;
}

#pragma mark - Collection view cell override

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.avatorButton setImage:nil forState:UIControlStateNormal];
    self.nameLabel.text = @"";
    self.dateTimeLabel.text = @"";
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    [self.replyButton setImage:nil forState:UIControlStateNormal];
    self.albumIndexPath = nil;
    self.delegate = nil;
    
    self.textLabel.text = @"";
    
    [self.mediaCollectionView prepareForReuse];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    SKTwitterTableLayoutAttributes *customAttributes = (SKTwitterTableLayoutAttributes *)layoutAttributes;
    
    CGFloat marginLeft = customAttributes.shouldContentIndent ?
        self.userInfoHolderViewMarginLeftConstraint.constant +
            self.avatorImageWidthConstraint.constant +
            self.imageView_NameLabel_HorizontalSpacingConstraint.constant :
        self.userInfoHolderViewMarginLeftConstraint.constant;
    
    // text view
    self.textLabelHeightConstraint.constant = customAttributes.textViewHeight;
    self.textLabelVerticalSpacing.constant = customAttributes.textViewHeight ? kSKTwitterCollectionViewCellMarginTopSpacing : 0;
    self.textLabelMarginLeftConstraint.constant = marginLeft;
    
    // TODO: media collection view
    self.mediaCollectionViewHeightConstraint.constant = customAttributes.mediaCollectionHolderViewHeight;
    self.mediaCollectionViewVerticalSpacing.constant = customAttributes.mediaCollectionHolderViewHeight ? kSKTwitterCollectionViewCellMarginTopSpacing : 0;
    self.mediaCollectionViewMarginLeftConstraint.constant = marginLeft;
}

#pragma mark - actions

- (IBAction)avatorButtonTouched:(id)sender {
    [self.delegate didSelectAvatorButtonInCollectionViewCell:self];
}

- (IBAction)replyButtonTouched:(id)sender {
    [self.delegate didSelectReplyButtonInCollectionViewCell:self];
}

@end
