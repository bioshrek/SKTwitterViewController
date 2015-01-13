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
#import "SKTwitterMediaCollectionViewFlowLayout.h"
#import "SKTwitterCollectionViewCell.h"


@interface SKTwitterTableLayout ()

@property (nonatomic, strong) NSCache *textViewHeightCache;

@property (nonatomic, strong) NSCache *mediaCollectionHeightCache;

@property (nonatomic, strong) SKTwitterMediaCollectionView *mediaCollectionViewForCalculatingLayout;

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

- (SKTwitterMediaCollectionView *)mediaCollectionViewForCalculatingLayout
{
    if (!_mediaCollectionViewForCalculatingLayout) {
        SKTwitterMediaCollectionView *mediaCollectionView = [[SKTwitterMediaCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[SKTwitterMediaCollectionViewFlowLayout alloc] init]];
        mediaCollectionView.backgroundColor = [UIColor lightGrayColor];
        mediaCollectionView.dataSource = self.collectionView.dataSource;  // very important
        mediaCollectionView.delegate = self.collectionView.delegate;  // very important
        _mediaCollectionViewForCalculatingLayout = mediaCollectionView;
    }
    return _mediaCollectionViewForCalculatingLayout;
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
    id<SKTwitterAlbum> album = [dataSource collectionView:self.collectionView albumForItemAtIndexPath:indexPath];
    
    CGFloat indent = [album shouldContentIndent] ? kSKTwitterCollectionViewCellAvatorImageWidth + kSKTwitterCollectionViewCellMarginLeftSpacing : 0;
    
    // text height
    NSAttributedString *attributedText = [album attributedText];
    CGFloat textViewHeight = [self textViewHeightForAttributedText:attributedText indent:indent];
    layoutAttributes.textViewHeight = textViewHeight;
    
    // media collection view height
    CGFloat mediaCollectionHolderViewHeight = [self mediaCollectionViewHeightWithDatasource:dataSource albumIndexPath:indexPath indent:indent];
    layoutAttributes.mediaCollectionHolderViewHeight = mediaCollectionHolderViewHeight;
    
    layoutAttributes.shouldContentIndent = [album shouldContentIndent];
}

// item height
- (CGFloat)heightForItemWithDataSource:(id<SKTwitterCollectionViewDataSource>)dataSource indexPath:(NSIndexPath *)indexPath
{
    
    id<SKTwitterAlbum> album = [dataSource collectionView:self.collectionView albumForItemAtIndexPath:indexPath];
    NSAttributedString *attributedText = [album attributedText];
    CGFloat indent = [album shouldContentIndent] ? kSKTwitterCollectionViewCellAvatorImageWidth + kSKTwitterCollectionViewCellMarginLeftSpacing : 0;
    CGFloat textViewHeight = [self textViewHeightForAttributedText:attributedText indent:indent];
    CGFloat textViewVerticalSpacing = textViewHeight ? kSKTwitterCollectionViewCellMarginTopSpacing : 0;
    
    CGFloat mediaCollectionHolderViewHeight = [self mediaCollectionViewHeightWithDatasource:dataSource albumIndexPath:indexPath indent:indent];
    CGFloat mediaCollectionViewVerticalSpacing = mediaCollectionHolderViewHeight ? kSKTwitterCollectionViewCellMarginTopSpacing : 0;
    
    CGFloat totalHeight =   kSKTwitterCollectionViewCellUserInfoHolderViewHeight + kSKTwitterCollectionViewCellMarginTopSpacing +
                            textViewHeight + textViewVerticalSpacing +
                            mediaCollectionHolderViewHeight + mediaCollectionViewVerticalSpacing;
    return totalHeight;
}

// text view height
- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)attributedText indent:(CGFloat)indent
{
    CGFloat height = 0.0f;
    
    if ([attributedText length]) {
        id cacheKey = @([attributedText.string hash]);
        NSNumber *heightValue = [self.textViewHeightCache objectForKey:cacheKey];
        
        if (!heightValue) {
            CGFloat maxWidth = self.itemWidth - kSKTwitterCollectionViewCellMarginLeftSpacing - kSKTwitterCollectionViewCellMarginRightSpacing - indent;
            CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                       options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                       context:nil];
            height = rect.size.height;  // TODO: need minimal adjust
            heightValue = [NSNumber numberWithFloat:height];
            [self.textViewHeightCache setObject:heightValue forKey:cacheKey];
        } else {
            height = [heightValue floatValue];
        }
    }
    
    return ceilf(height);
}

// media collection view height
- (CGFloat)mediaCollectionViewHeightWithDatasource:(id<SKTwitterCollectionViewDataSource>)dataSource
                              albumIndexPath:(NSIndexPath *)indexPath
                                      indent:(CGFloat)indent
{
    CGFloat height = 0.0f;
    NSInteger numberOfMediaSections = [dataSource numberOfMediaSectionsForAlbumAtIndexPath:indexPath];
    if (numberOfMediaSections) {
        NSMutableArray *mediaDisplaySizeSectionList = [[NSMutableArray alloc] init];
        NSMutableArray *mediaDisplaySizeList = nil;
        for (NSUInteger section = 0; section < numberOfMediaSections; section++) {
            @autoreleasepool {
                mediaDisplaySizeList = [[NSMutableArray alloc] init];
                for (NSUInteger item = 0; item < [dataSource numberOfMediaInSection:section forAlbumAtIndexPath:indexPath]; item++) {
                    @autoreleasepool {
                        CGSize mediaDisplaySize = [dataSource mediaDisplaySizeForMediaAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]
                                                                              forAlbumAtIndexPath:indexPath];
                        [mediaDisplaySizeList addObject:[NSValue valueWithCGSize:mediaDisplaySize]];
                    }
                }
                [mediaDisplaySizeSectionList addObject:mediaDisplaySizeList];
            }
        }
        NSNumber *heightValue = [self.mediaCollectionHeightCache objectForKey:mediaDisplaySizeSectionList];
        if (!heightValue) {  // calculate
            CGFloat maxWidth = self.itemWidth - kSKTwitterCollectionViewCellMarginLeftSpacing - kSKTwitterCollectionViewCellMarginRightSpacing - indent;
            self.mediaCollectionViewForCalculatingLayout.albumIndexPath = indexPath;
            self.mediaCollectionViewForCalculatingLayout.bounds = CGRectMake(0, 0, maxWidth, 200);  // important: content size calculation needs max width
            UICollectionViewLayout *layout = self.mediaCollectionViewForCalculatingLayout.collectionViewLayout;
            [self.mediaCollectionViewForCalculatingLayout reloadData];
            [layout invalidateLayout];
            CGSize contentSize = [layout collectionViewContentSize];
            height = contentSize.height;
            
            heightValue = [NSNumber numberWithFloat:height];
            [self.mediaCollectionHeightCache setObject:heightValue forKey:mediaDisplaySizeSectionList];
        } else {  // cached
            height = [heightValue floatValue];
        }
    }
    
    return ceilf(height);
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // text height
    id<SKTwitterCollectionViewDataSource> dataSource = self.collectionView.skTwitterCollectionViewDataSource;
    CGFloat totalHeight = [self heightForItemWithDataSource:dataSource indexPath:indexPath];
    
    return CGSizeMake(self.itemWidth, ceilf(totalHeight));
}


@end
