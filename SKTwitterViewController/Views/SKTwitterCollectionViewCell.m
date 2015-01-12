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

@interface SKTwitterCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UserInfoHolderViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelVerticalSpacing;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelHeightConstraint;

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

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.avatorImageView.image = nil;
    self.nameLabel.text = @"";
    self.dateTimeLabel.text = @"";
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    
    self.textLabel.text = @"";
    
    [self.mediaCollectionView prepareForReuse];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    SKTwitterTableLayoutAttributes *customAttributes = (SKTwitterTableLayoutAttributes *)layoutAttributes;
    
    // text view
    self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(customAttributes.frame) - 8 - 8;
    self.textLabelHeightConstraint.constant = customAttributes.textViewHeight;
    self.textLabelVerticalSpacing.constant = customAttributes.textViewVerticalSpacing;
    
    // TODO: media collection view
    self.mediaCollectionViewHeightConstraint.constant = customAttributes.mediaCollectionHolderViewHeight;
    self.mediaCollectionViewVerticalSpacing.constant = customAttributes.mediaCollectionHolderViewVerticalSpacing;
}
@end
