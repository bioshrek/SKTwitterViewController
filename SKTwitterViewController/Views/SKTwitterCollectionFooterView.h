//
//  SKTwitterCollectionFooterView.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/14/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Layout constants

extern CGFloat const kSKTwitterCollectionFooterViewHeight;

@interface SKTwitterCollectionFooterView : UICollectionReusableView

@property (weak, nonatomic, readonly) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic, readonly) UILabel *label;

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
