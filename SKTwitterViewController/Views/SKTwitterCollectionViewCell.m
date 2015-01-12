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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewVerticalSpacing;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaCollectionViewVerticalSpacing;
@property (weak, nonatomic) IBOutlet UICollectionReusableView *mediaCollectionHolderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaCollectionHolderViewHeightConstraint;

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
    self.textView.contentInset = UIEdgeInsetsMake(kTextViewContentInsetsTop,
                                                  kTextViewContentInsetsLeft,
                                                  kTextViewContentInsetsBottom,
                                                  kTextViewContentInsetsRight);
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.avatorImageView.image = nil;
    self.nameLabel.text = @"";
    self.dateTimeLabel.text = @"";
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    
    self.textView.text = @"";
    
    // recycle media collection view
    [self.mediaCollectionView removeFromSuperview];
    [self.mediaCollectionView.mediaCollectionViewDelegate recycleMediaCollectionView:self.mediaCollectionView];
    self.mediaCollectionView = nil;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    SKTwitterTableLayoutAttributes *customAttributes = (SKTwitterTableLayoutAttributes *)layoutAttributes;
    
    // text view
    self.textViewHeightConstraint.constant = customAttributes.textViewHeight;
    self.textViewVerticalSpacing.constant = customAttributes.textViewVerticalSpacing;
    
    
    // TODO: media collection view
    self.mediaCollectionHolderViewHeightConstraint.constant = customAttributes.mediaCollectionHolderViewHeight;
    self.mediaCollectionViewVerticalSpacing.constant = customAttributes.mediaCollectionHolderViewVerticalSpacing;
}

@end
