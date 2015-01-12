//
//  SKTwitterTableLayoutAttributes.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterTableLayoutAttributes.h"

#pragma mark - layout constants

@implementation SKTwitterTableLayoutAttributes

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    SKTwitterTableLayoutAttributes *copy = [super copyWithZone:zone];
    
    if (copy.representedElementCategory == UICollectionElementCategoryCell) {
        copy.textViewVerticalSpacing = self.textViewVerticalSpacing;
        copy.textViewHeight = self.textViewHeight;
        
        copy.mediaCollectionHolderViewHeight = self.mediaCollectionHolderViewHeight;
        copy.mediaCollectionHolderViewVerticalSpacing = self.mediaCollectionHolderViewVerticalSpacing;
    }
    
    return copy;
}


- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    if (self.representedElementCategory == UICollectionElementCategoryCell) {
        SKTwitterTableLayoutAttributes *otherAttributes = (SKTwitterTableLayoutAttributes *)other;
        if (otherAttributes.textViewVerticalSpacing != self.textViewVerticalSpacing ||
            otherAttributes.textViewHeight != self.textViewHeight ||
            otherAttributes.mediaCollectionHolderViewHeight != self.mediaCollectionHolderViewHeight ||
            otherAttributes.mediaCollectionHolderViewVerticalSpacing != self.mediaCollectionHolderViewVerticalSpacing) {
            return NO;
        }
    }
    
    return [super isEqual:other];
}


- (NSUInteger)hash
{
    return [self.indexPath hash];
}

@end

