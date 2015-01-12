//
//  SKTwitterMediaView.h
//  SKTwitterViewControllerDemo
//
//  Created by shrek wang on 1/10/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MRProgress.h>

@class SKTwitterMediaView;

@protocol SKTwitterMediaViewDelegate <NSObject>

- (void)recycleMediaView:(SKTwitterMediaView *)mediaView;

@end

@interface SKTwitterMediaView : UICollectionViewCell

@property (nonatomic, weak, readonly) UIImageView *backgroundImageView;
@property (nonatomic, weak, readonly) UIView *mediaTextInfoHolderView;
@property (nonatomic, weak, readonly) UILabel *mediaNameLabel;
@property (nonatomic, weak, readonly) UILabel *mediaSizeLabel;

@property (weak, nonatomic, readonly) UIView *progressHolderView;
@property (weak, nonatomic, readonly) NSLayoutConstraint *progressHolderViewCenterYConstraint;
@property (nonatomic, weak, readonly) MRCircularProgressView *circularProgressView;
@property (weak, nonatomic, readonly) NSLayoutConstraint *circularProgressViewCenterXConstraint;
@property (weak, nonatomic, readonly) UILabel *progressLabel;
@property (weak, nonatomic, readonly) NSLayoutConstraint *progressLabelCenterXConstraint;

@property (nonatomic, weak, readonly) UIButton *mediaIconButton;
@property (weak, nonatomic, readonly) NSLayoutConstraint *mediaIconButtonCenterYConstraint;

@property (nonatomic, weak) id<SKTwitterMediaViewDelegate> delegate;

+ (UINib *)nib;

+ (NSString *)reuseIdentifier;

@end
