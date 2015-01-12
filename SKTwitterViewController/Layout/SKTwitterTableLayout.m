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
#import "SKTwitterMediaCollectionView.h"

#pragma mark - layout constants

CGFloat kUserInfoHolderViewHeight = 44.0f;
CGFloat kVerticalSpacing = 8.0f;


@interface SKTwitterTableLayout ()

@property (nonatomic, strong) NSCache *textViewHeightCache;

@property (nonatomic, strong) NSCache *mediaCollectionHeightCache;

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

- (NSCache *)mediaCollectionHeightCache
{
    if (!_mediaCollectionHeightCache) {
        _mediaCollectionHeightCache = [[NSCache alloc] init];
    }
    return _mediaCollectionHeightCache;
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
    NSIndexPath *indexPath = layoutAttributes.indexPath;
    
    id<SKTwitterCollectionViewDataSource> dataSource = self.collectionView.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self.collectionView albumForItemAtRow:indexPath.item];
    
    // text height
    NSAttributedString *attributedText = [album attributedText];
    CGFloat textViewHeight = [self textViewHeightForAttributedText:attributedText];
    layoutAttributes.textViewHeight = textViewHeight;
    layoutAttributes.textViewVerticalSpacing = textViewHeight ? kVerticalSpacing : 0;
    
    // media collection view height
    CGFloat mediaCollectionHolderViewHeight = [self mediaCollectionViewHeightForAlbum:album albumIndexPath:indexPath];
    layoutAttributes.mediaCollectionHolderViewHeight = mediaCollectionHolderViewHeight;
    layoutAttributes.mediaCollectionHolderViewVerticalSpacing = mediaCollectionHolderViewHeight ? kVerticalSpacing : 0;
}

// item height
- (CGFloat)heightForItemWithAlbum:(id<SKTwitterAlbum>)album indexPath:(NSIndexPath *)indexPath
{
    NSAttributedString *attributedText = [album attributedText];
    CGFloat textViewHeight = [self textViewHeightForAttributedText:attributedText];
    CGFloat textViewVerticalSpacing = textViewHeight ? kVerticalSpacing : 0;
    
    CGFloat mediaCollectionHolderViewHeight = [self mediaCollectionViewHeightForAlbum:album albumIndexPath:indexPath];
    CGFloat mediaCollectionViewVerticalSpacing = mediaCollectionHolderViewHeight ? kVerticalSpacing : 0;
    
    CGFloat totalHeight =   kUserInfoHolderViewHeight +
    textViewHeight + textViewVerticalSpacing +
    mediaCollectionHolderViewHeight + mediaCollectionViewVerticalSpacing;
    
    return totalHeight;
}

// text view height
- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)attributedText
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

// media collection view height
- (CGFloat)mediaCollectionViewHeightForAlbum:(id<SKTwitterAlbum>)album
           albumIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    NSInteger numberOfMediaItems = [album numberOfMediaItems];

    if (numberOfMediaItems) {
        NSMutableArray *mediaDisplaySizeList = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < [album numberOfMediaItems]; i++) {
            @autoreleasepool {
                id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndex:i];
                [mediaDisplaySizeList addObject:[NSValue valueWithCGSize:[media mediaDisplaySize]]];
            }
        }
        NSNumber *heightValue = [self.mediaCollectionHeightCache objectForKey:mediaDisplaySizeList];
        if (!heightValue) {  // calculate
            SKTwitterMediaCollectionView *mediaCollectionView = [self.collectionView dequeueReusableMediaCollectionViewForItemAtIndexPath:indexPath];
            if (mediaCollectionView) {
                [mediaCollectionView reloadData];
                UICollectionViewLayout *layout = mediaCollectionView.collectionViewLayout;
                CGSize contentSize = [layout collectionViewContentSize];
//                height = contentSize.height;
                height = 200;
                [self.collectionView recycleMediaCollectionView:mediaCollectionView];
                
                heightValue = [NSNumber numberWithFloat:height];
                [self.mediaCollectionHeightCache setObject:heightValue forKey:mediaDisplaySizeList];
            }
        } else {  // cached
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
    CGFloat totalHeight = [self heightForItemWithAlbum:album indexPath:indexPath];
    
    return CGSizeMake(self.itemWidth, ceilf(totalHeight));
}


@end
