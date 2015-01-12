//
//  SKTwitterMediaView.m
//  SKTwitterViewControllerDemo
//
//  Created by shrek wang on 1/10/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterMediaView.h"

// layout constants
CGFloat const kProgressHolderViewCenterY = 24.0f;
CGFloat const kCircularProgressViewCenterX = 60.0f;
CGFloat const kProgressLabelCenterX = -29.0f;
CGFloat const kErrorButtonCenterY = 24.0f;
CGFloat const kMediaIconViewCenterY = 24.0f;

@interface SKTwitterMediaView ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIView *mediaTextInfoHolderView;
@property (nonatomic, weak) IBOutlet UILabel *mediaNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *mediaSizeLabel;


@property (weak, nonatomic) IBOutlet UIView *progressHolderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressHolderViewCenterYConstraint;
@property (nonatomic, weak) IBOutlet MRCircularProgressView *circularProgressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circularProgressViewCenterXConstraint;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressLabelCenterXConstraint;

@property (nonatomic, weak) IBOutlet UIButton *mediaIconButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaIconButtonCenterYConstraint;

@end

@implementation SKTwitterMediaView

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.backgroundImageView.image = nil;
    self.mediaNameLabel.attributedText = nil;
    self.mediaSizeLabel.attributedText = nil;
    self.circularProgressView.progress = 0;
    [self.mediaIconButton setImage:nil forState:UIControlStateNormal];
    [self.mediaIconButton setAttributedTitle:nil forState:UIControlStateNormal];
}

@end
