//
//  SKTwitterCollectionViewCell.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionViewCell.h"

#import "SKTwitterTableLayoutAttributes.h"

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
    
    // TODO:
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    SKTwitterTableLayoutAttributes *customAttributes = (SKTwitterTableLayoutAttributes *)layoutAttributes;
    // TODO:
}

@end
