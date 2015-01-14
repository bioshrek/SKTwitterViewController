//
//  SKTwitterCollectionFooterView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/14/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionFooterView.h"

CGFloat const kSKTwitterCollectionFooterViewHeight = 44.0f;

@interface SKTwitterCollectionFooterView ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SKTwitterCollectionFooterView

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.activityIndicator stopAnimating];
    self.label.text = nil;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
