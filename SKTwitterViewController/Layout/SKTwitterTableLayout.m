//
//  SKTwitterTableLayout.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterTableLayout.h"

#import "SKTwitterTableLayoutAttributes.h"
#import "SKTwitterTableLayoutInvalidationContext.h"

@implementation SKTwitterTableLayout

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInitSKTwitterTableLayoutAttributes];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitSKTwitterTableLayoutAttributes];
}

+ (Class)layoutAttributesClass
{
    return [SKTwitterTableLayoutAttributes class];
}

+ (Class)invalidationContextClass
{
    return [SKTwitterTableLayoutInvalidationContext class];
}

- (void)commonInitSKTwitterTableLayoutAttributes
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
}

#pragma mark - getter

- (CGFloat)itemWidth
{
    return CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right;
}

#pragma mark - Collection view flow layout

- (void)invalidateLayoutWithContext:(SKTwitterTableLayoutInvalidationContext *)context
{
    if (context.invalidateDataSourceCounts) {
        context.invalidateFlowLayoutAttributes = YES;
        context.invalidateFlowLayoutDelegateMetrics = YES;
    }
    
    if (context.emptyCache) {
        // TODO: empty cache
    }
    
    [super invalidateLayoutWithContext:context];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // TODO:
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    [attributesInRect enumerateObjectsUsingBlock:^(SKTwitterTableLayoutAttributes *attributesItem, NSUInteger idx, BOOL *stop) {
        if (attributesItem.representedElementCategory == UICollectionElementCategoryCell) {
            [self configureMessageCellLayoutAttributes:attributesItem];
        }
        else {
            attributesItem.zIndex = -1;
        }
    }];
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKTwitterTableLayoutAttributes *customAttributes = (SKTwitterTableLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (customAttributes.representedElementCategory == UICollectionElementCategoryCell) {
        [self configureMessageCellLayoutAttributes:customAttributes];
    }
    
    return customAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            
            CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.bounds);
            
            SKTwitterTableLayoutAttributes *attributes = [SKTwitterTableLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
            
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                [self configureMessageCellLayoutAttributes:attributes];
            }
            
            attributes.frame = CGRectMake(0.0f,
                                          collectionViewHeight + CGRectGetHeight(attributes.frame),
                                          CGRectGetWidth(attributes.frame),
                                          CGRectGetHeight(attributes.frame));
        }
    }];
}

#pragma mark - calculate layout attributes

- (void)configureMessageCellLayoutAttributes:(SKTwitterTableLayoutAttributes *)layoutAttributes
{
    // TODO:
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO:
    return 44.0f;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat finalHeight = [self heightForItemAtIndexPath:indexPath];
    
    return CGSizeMake(self.itemWidth, ceilf(finalHeight));
}


@end
