//
//  SKTwitterCollectionHeaderView.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/15/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kSKTwitterCollectionHeaderViewHeight;

@interface SKTwitterCollectionHeaderView : UICollectionReusableView

@property (weak, nonatomic, readonly) UILabel *label;

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
