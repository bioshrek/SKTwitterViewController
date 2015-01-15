//
//  SKTwitterCollectionHeaderView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/15/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionHeaderView.h"

CGFloat const kSKTwitterCollectionHeaderViewHeight = 44.0f;

@interface SKTwitterCollectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SKTwitterCollectionHeaderView

- (void)prepareForReuse
{
    [super prepareForReuse];
    
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
