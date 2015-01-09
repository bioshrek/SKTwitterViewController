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

#pragma mark - layout constants

CGFloat kUserInfoHolderViewHeight = 44.0f;
CGFloat kVerticalSpacing = 8.0f;


@interface SKTwitterTableLayout ()

@property (nonatomic, strong) NSCache *textViewHeightCache;

@end

@implementation SKTwitterTableLayout

#pragma mark - getter

- (NSCache *)textViewHeightCache
{
    if (!_textViewHeightCache) {
        _textViewHeightCache = [[NSCache alloc] init];
    }
    return _textViewHeightCache;
}

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
    self.sectionInset = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
    self.minimumLineSpacing = 20.0f;
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
            [self configureAlbumCellLayoutAttributes:attributesItem];
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
        [self configureAlbumCellLayoutAttributes:customAttributes];
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
                [self configureAlbumCellLayoutAttributes:attributes];
            }
            
            attributes.frame = CGRectMake(0.0f,
                                          collectionViewHeight + CGRectGetHeight(attributes.frame),
                                          CGRectGetWidth(attributes.frame),
                                          CGRectGetHeight(attributes.frame));
        }
    }];
}

#pragma mark - calculate layout attributes

- (void)configureAlbumCellLayoutAttributes:(SKTwitterTableLayoutAttributes *)layoutAttributes
{
    // TODO:
    NSInteger row = layoutAttributes.indexPath.item;
    
    
    id<SKTwitterCollectionViewDataSource> dataSource = self.collectionView.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self.collectionView albumForItemAtRow:row];
    
    
    // text height
    NSAttributedString *attributedText = [album attributedText];
    CGFloat textViewHeight = [self heightForTextViewWithAttributedText:attributedText];
    layoutAttributes.textViewHeight = textViewHeight;
    layoutAttributes.textViewVerticalSpacing = textViewHeight ? kVerticalSpacing : 0;
    
    
    // TODO: media collection view height
    layoutAttributes.mediaCollectionHolderViewHeight = 0.0f;
    layoutAttributes.mediaCollectionHolderViewVerticalSpacing = 0.0f;
}

// item height
- (CGFloat)heightForItemWithAttributedText:(NSAttributedString *)attributedText
{
    // TODO:
    CGFloat textViewHeight = [self heightForTextViewWithAttributedText:attributedText];
    CGFloat textViewVerticalSpacing = textViewHeight ? kVerticalSpacing : 0;
    
    BOOL hasMediaCollection = NO;
    CGFloat mediaCollectionViewHeight = 0.0f;
    CGFloat mediaCollectionViewVerticalSpacing = mediaCollectionViewHeight ? kVerticalSpacing : 0;
    
    CGFloat totalHeight =   kUserInfoHolderViewHeight +
    textViewHeight + textViewVerticalSpacing +
    mediaCollectionViewHeight + mediaCollectionViewVerticalSpacing;
    
    return totalHeight;
}

// text view height
- (CGFloat)heightForTextViewWithAttributedText:(NSAttributedString *)attributedText
{
    CGFloat height = 0.0f;
    
    if ([attributedText length]) {
        id cacheKey = @([attributedText.string hash]);
        NSNumber *heightValue = [self.textViewHeightCache objectForKey:cacheKey];
        
        if (!heightValue) {
            CGFloat maxWidth = self.itemWidth;
            CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                       options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                       context:nil];
            height = rect.size.height + kTextViewContentInsetsTop + kTextViewContentInsetsBottom;
            
            heightValue = [NSNumber numberWithFloat:height];
            [self.textViewHeightCache setObject:heightValue forKey:cacheKey];
        } else {
            height = [heightValue floatValue];
        }
    }
    
    return height;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.item;
    
    // text height
    id<SKTwitterCollectionViewDataSource> dataSource = self.collectionView.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self.collectionView albumForItemAtRow:row];
    NSAttributedString *attributedText = [album attributedText];
    CGFloat totalHeight = [self heightForItemWithAttributedText:attributedText];
    
    return CGSizeMake(self.itemWidth, ceilf(totalHeight));
}


@end
