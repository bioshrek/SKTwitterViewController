//
//  SKTwitterMediaCollectionViewFlowLayout.m
//  SKTwitterViewControllerDemo
//
//  Created by shrek wang on 1/12/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterMediaCollectionViewFlowLayout.h"

@implementation SKTwitterMediaCollectionViewFlowLayout

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInitSKTwitterMediaCollectionViewFlowLayout];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitSKTwitterMediaCollectionViewFlowLayout];
}

- (void)commonInitSKTwitterMediaCollectionViewFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(4.0f, 0.0f, 4.0f, 0.0f);
    self.minimumLineSpacing = 8.0f;
    self.minimumInteritemSpacing = 8.0f;
}

#pragma mark - Collection view flow layout

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context
{
    [super invalidateLayoutWithContext:context];
    
    // TODO:
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // TODO:
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    // special layout for section with only 4 items
    NSMutableSet *specialSectionSet = [[NSMutableSet alloc] init];
    NSUInteger sectionCount = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
    for (NSInteger section = 0; section < sectionCount; section++) {
        @autoreleasepool {
            NSUInteger itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
            if (4 == itemCount) {  // special section
                [specialSectionSet addObject:[NSNumber numberWithInteger:section]];
            }
        }
    }
    
    // adjust originX, make cell align left ASAP.
    CGRect previousFrame = CGRectZero;
    CGFloat originY = 0.0f;
    NSInteger specialItemIndex = NSNotFound;
    for (NSUInteger i = 0; i < [attributesInRect count]; i++) {
        @autoreleasepool {
            UICollectionViewLayoutAttributes *layoutAttributes = [attributesInRect objectAtIndex:i];
            CGRect originalFrame = layoutAttributes.frame;
            UIEdgeInsets insetForSection = self.sectionInset;
            
            // tag the begging and ending of special section
            if ([specialSectionSet containsObject:[NSNumber numberWithInteger:layoutAttributes.indexPath.section]]) {
                if (NSNotFound == specialItemIndex) {
                    specialItemIndex = 0;
                } else {
                    specialItemIndex++;
                }
            } else {
                specialItemIndex = NSNotFound;
            }
            
            // adjust origin X
            CGFloat y = CGRectGetMinY(layoutAttributes.frame);
            if (y > originY) {  // new line
                
                // 1 row can at least layout 2 items
                // adjust special layout
                if (3 == specialItemIndex) {  // found special case
                    UICollectionViewLayoutAttributes *previousLayoutAttributes = [attributesInRect objectAtIndex:i - 1];
                    previousLayoutAttributes.frame = CGRectMake(insetForSection.left + self.minimumInteritemSpacing,
                                                                originalFrame.origin.y,
                                                                originalFrame.size.width,
                                                                originalFrame.size.height);
                    
                    layoutAttributes.frame = CGRectMake(CGRectGetMaxX(previousLayoutAttributes.frame) + self.minimumInteritemSpacing,
                                                        originalFrame.origin.y,
                                                        originalFrame.size.width,
                                                        originalFrame.size.height);
                } else {  // normal case
                    layoutAttributes.frame = CGRectMake(insetForSection.left + self.minimumInteritemSpacing,
                                                        originalFrame.origin.y,
                                                        originalFrame.size.width,
                                                        originalFrame.size.height);
                }
            } else {  // same line
                
                layoutAttributes.frame = CGRectMake(CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing,
                                                    originalFrame.origin.y,
                                                    originalFrame.size.width,
                                                    originalFrame.size.height);
            }
            originY = y;
            previousFrame = layoutAttributes.frame;
            
            // calculate custom layout attributes
            if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
                [self configureMediaCellLayoutAttributes:layoutAttributes];
            }
            
            
        }
    }
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *customAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (customAttributes.representedElementCategory == UICollectionElementCategoryCell) {
        [self configureMediaCellLayoutAttributes:customAttributes];
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

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds
{
    UICollectionViewFlowLayoutInvalidationContext *flowLayoutInvalidationContext = (UICollectionViewFlowLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    flowLayoutInvalidationContext.invalidateFlowLayoutDelegateMetrics = NO;
    flowLayoutInvalidationContext.invalidateFlowLayoutAttributes = YES;
    
    return flowLayoutInvalidationContext;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
            
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                [self configureMediaCellLayoutAttributes:attributes];
            }
        }
    }];
}

- (void)configureMediaCellLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // TODO: 
//    NSLog(@"media item %d, frame: %@", (int)layoutAttributes.indexPath.item, NSStringFromCGRect(layoutAttributes.frame));
}

@end
