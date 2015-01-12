//
//  SKTwitterCollectionView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionView.h"

#import "SKTwitterCollectionViewCell.h"

@interface SKTwitterCollectionView ()

// List<media collection view>
@property (nonatomic, strong) NSMutableArray *mediaCollectionViewReusableQueue;

// Map<ReusableIdentifier, Map<layout, List<ReusableMediaView>>>
@property (nonatomic, strong) NSMutableDictionary *mediaViewReusableQueue;

// Map<identifier, nib>
@property (nonatomic, strong) NSMutableDictionary *mediaViewNibMap;

// Map<identifier, class>
@property (nonatomic, strong) NSMutableDictionary *mediaViewClassMap;

@end

@implementation SKTwitterCollectionView

#pragma mark - getter

- (NSMutableArray *)mediaCollectionViewReusableQueue
{
    if (!_mediaCollectionViewReusableQueue) {
        _mediaCollectionViewReusableQueue = [[NSMutableArray alloc] init];
    }
    return _mediaCollectionViewReusableQueue;
}

- (NSMutableDictionary *)mediaViewReusableQueue
{
    if (!_mediaViewReusableQueue) {
        _mediaViewReusableQueue = [[NSMutableDictionary alloc] init];
    }
    return _mediaViewReusableQueue;
}

- (NSMutableDictionary *)mediaViewNibMap
{
    if (!_mediaViewNibMap) {
        _mediaViewNibMap = [[NSMutableDictionary alloc] init];
    }
    return _mediaViewNibMap;
}

- (NSMutableDictionary *)mediaViewClassMap
{
    if (!_mediaViewClassMap) {
        _mediaViewClassMap = [[NSMutableDictionary alloc] init];
    }
    return _mediaViewClassMap;
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInitSKTwitterCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitSKTwitterCollectionView];
}

- (void)commonInitSKTwitterCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    [self registerNib:[SKTwitterCollectionViewCell nib]
forCellWithReuseIdentifier:[SKTwitterCollectionViewCell cellReuseIdentifier]];
    
    [self registerNib:[SKTwitterMediaView nib]
forMediaViewWithReuseIdentifier:[SKTwitterMediaView reuseIdentifier]];
}

#pragma mark - Reusing media collectio view

- (SKTwitterMediaCollectionView *)dequeueReusableMediaCollectionViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtRow:indexPath.item];
    
    SKTwitterMediaCollectionView *mediaCollectionView = nil;
    if ([album numberOfMediaItems]) {
        mediaCollectionView = [self.mediaCollectionViewReusableQueue firstObject];
        if (mediaCollectionView) {  // reusable media view available
            [self.mediaCollectionViewReusableQueue removeObjectAtIndex:0];
            [mediaCollectionView prepareForReuse];
        } else {  // new instance
            mediaCollectionView = [[SKTwitterMediaCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
            mediaCollectionView.backgroundColor = [UIColor whiteColor];
            mediaCollectionView.dataSource = self;  // very important
            mediaCollectionView.delegate = self;  // very important
            mediaCollectionView.mediaCollectionViewDelegate = self;
        }
        mediaCollectionView.albumIndexPath = indexPath;  // very important
    }
    
    return mediaCollectionView;
}

- (void)recycleMediaCollectionView:(SKTwitterMediaCollectionView *)mediaCollectionView
{
    if (nil == mediaCollectionView) {
        return;
    }
    
    [self.mediaCollectionViewReusableQueue addObject:mediaCollectionView];
}

#pragma mark - Reusing media cell

- (void)registerNib:(UINib *)nib forMediaViewWithReuseIdentifier:(NSString *)identifier
{
    NSParameterAssert(nil != nib && [identifier length]);
    
    [self.mediaViewNibMap setValue:nib forKey:identifier];
}

- (void)registerClass:(Class)cellClass forMediaViewWithReuseIdentifier:(NSString *)identifier
{
    NSParameterAssert(nil != cellClass && [identifier length]);
    
    [self.mediaViewClassMap setValue:cellClass forKey:identifier];
}

- (SKTwitterMediaView *)createMediaViewWithReuseIdentifier:(NSString *)identifier withFrame:(CGRect)frame
{
    // nib, or class
    
    UINib *nib = [self.mediaViewNibMap valueForKey:identifier];
    Class class = [self.mediaViewClassMap valueForKey:identifier];
    
    SKTwitterMediaView *mediaView = nil;
    if (nib) {
        mediaView = [[nib instantiateWithOwner:nil options:kNilOptions] firstObject];
    } else {
        if (class) {
            mediaView = [(SKTwitterMediaView *)[class alloc] initWithFrame:frame];
        }
    }
    
    return mediaView;
}

- (SKTwitterMediaView *)dequeueReusableMediaViewWithReuseIdentifier:(NSString *)identifier
                                                       forItemAtRow:(NSUInteger)row
                                                      forMediaIndex:(NSUInteger)mediaIndex
{
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtRow:row];
    id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndex:mediaIndex];
    CGSize mediaViewDisplaySize = [media mediaDisplaySize];
    SKTwitterMediaView *mediaView = [self dqueueMediaViewForMediaViewDisplaySize:mediaViewDisplaySize inMediaViewReusableQueue:[self mediaViewReusableQueueForReuseIdentifier:identifier]];
    if (mediaView) {  // reusable media view available
        [mediaView prepareForReuse];
    } else {  // new instance
        mediaView = [self createMediaViewWithReuseIdentifier:identifier withFrame:CGRectMake(0, 0, mediaViewDisplaySize.width, mediaViewDisplaySize.height)];
        mediaView.delegate = self;
    }
    
    return mediaView;
}

- (NSMutableDictionary *)mediaViewReusableQueueForReuseIdentifier:(NSString *)identifier
{
    NSMutableDictionary *mediaViewReusableQueue = [self.mediaViewReusableQueue valueForKey:identifier];
    if (nil == mediaViewReusableQueue) {
        mediaViewReusableQueue = [[NSMutableDictionary alloc] init];
        [self.mediaViewReusableQueue setValue:mediaViewReusableQueue forKey:identifier];
    }
    
    return mediaViewReusableQueue;
}

// Map<size, List<mediaView>>
- (SKTwitterMediaView *)dqueueMediaViewForMediaViewDisplaySize:(CGSize)mediaViewDisplaySize
                                inMediaViewReusableQueue:(NSMutableDictionary *)mediaViewReusableQueue
{
    NSParameterAssert(nil != mediaViewReusableQueue);
    
    NSValue *sizeKey = [NSValue valueWithCGSize:mediaViewDisplaySize];
    NSMutableArray *mediaViews = [mediaViewReusableQueue objectForKey:sizeKey];
    if (nil == mediaViews) {
        mediaViews = [[NSMutableArray alloc] init];
        [mediaViewReusableQueue setObject:mediaViews forKey:sizeKey];
    }
    
    SKTwitterMediaView *mediaView = nil;
    if ([mediaViews count]) {
        mediaView = [mediaViews firstObject];
        [mediaViews removeObjectAtIndex:0];
    }
    
    return mediaView;
}

// Map<size, List<mediaView>>
- (void)enqueueMediaView:(UICollectionReusableView *)mediaView inMediaViewReusableQueue:(NSMutableDictionary *)mediaViewReusableQueue
{
    NSParameterAssert(nil != mediaView && nil != mediaViewReusableQueue);
    
    CGSize mediaViewDisplaySize = mediaView.bounds.size;
    
    NSValue *sizeKey = [NSValue valueWithCGSize:mediaViewDisplaySize];
    NSMutableArray *mediaViews = [mediaViewReusableQueue objectForKey:sizeKey];
    if (nil == mediaViews) {
        mediaViews = [[NSMutableArray alloc] init];
        [mediaViewReusableQueue setObject:mediaViews forKey:sizeKey];
    }
    
    [mediaViews addObject:mediaView];
}

- (void)recycleMediaView:(SKTwitterMediaView *)mediaView
{
    if (nil == mediaView) {
        return;
    }
    
    [self enqueueMediaView:mediaView inMediaViewReusableQueue:[self mediaViewReusableQueueForReuseIdentifier:mediaView.reuseIdentifier]];
}

#pragma mark - Media Collection view DataSource, delegate

- (NSInteger)collectionView:(SKTwitterMediaCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<SKTwitterAlbum> album = [self.skTwitterCollectionViewDataSource collectionView:self albumForItemAtRow:collectionView.albumIndexPath.item];
    NSAssert(album, @"album should not be nil");
    
    return [album numberOfMediaItems];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(SKTwitterMediaCollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [SKTwitterMediaView reuseIdentifier];
    SKTwitterMediaView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSAssert(cell, @"media cell can't be nil");
    
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    NSInteger row = collectionView.albumIndexPath.item;
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtRow:row];
    NSAssert(album, @"album should not be nil");
    NSInteger mediaIndex = indexPath.item;
    id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndex:mediaIndex];
    
    // media state
    SKMessageMediaState mediaState = [media mediaState];
    [self renderMediaView:cell media:media row:row mediaIndex:mediaIndex];
    
    // media progress
    if (SKMessageMediaStateUploading == mediaState ||
        SKMessageMediaStateDownloading == mediaState) {
        [self renderMediaView:cell withMediaProgress:[media mediaProgress]];
    }
    
    // media thumbnail
    UIImage *thumbnail = [dataSource collectionView:self thumbnailForMediaState:mediaState forItemAtRow:row forMediaItemAtIndex:mediaIndex];
    cell.backgroundImageView.image = thumbnail;
    
    return cell;
}

- (CGSize)collectionView:(SKTwitterMediaCollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    NSInteger row = collectionView.albumIndexPath.item;
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtRow:row];
    NSAssert(album, @"album should not be nil");
    NSInteger mediaIndex = indexPath.item;
    id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndex:mediaIndex];
    
    return [media mediaDisplaySize];
}

#pragma mark - render media view

- (void)renderMediaView:(SKTwitterMediaView *)skMediaView
                  media:(id<SKTwitterAlbumMedia>)media
                    row:(NSInteger)row
             mediaIndex:(NSInteger)mediaIndex
{
    if (nil == skMediaView) return;
    
    SKMessageMediaState mediaState = [media mediaState];
    
    NSAttributedString *mediaDescriptionForState = nil;
    UIImage *mediaIconForState = nil;
    NSAttributedString *mediaNameText = nil;
    NSAttributedString *mediaSizeText = nil;
    BOOL shouldShowMediaTextInfo = NO;
    
    // text info view
    shouldShowMediaTextInfo = [media shouldShowMediaTextInfoForMediaState:mediaState];
    if (shouldShowMediaTextInfo) {
        mediaNameText = [media mediaNameAttributedText];
        mediaSizeText = [media mediaSizeAttributedText];
        
        skMediaView.mediaTextInfoHolderView.hidden = NO;
        skMediaView.mediaNameLabel.attributedText = mediaNameText;
        skMediaView.mediaSizeLabel.attributedText = mediaSizeText;
    } else {
        skMediaView.mediaTextInfoHolderView.hidden = YES;
    }
    
    // media icon, media description, progress
    mediaDescriptionForState = [media mediaDescriptionForMediaState:mediaState];
    if (SKMessageMediaStateUploading == mediaState ||
        SKMessageMediaStateDownloading == mediaState) {
        skMediaView.mediaIconButton.hidden = YES;
        
        skMediaView.circularProgressView.borderWidth = 1.0f;
        skMediaView.circularProgressView.lineWidth = 25.0f;
        [skMediaView.circularProgressView.valueLabel removeFromSuperview];
        skMediaView.progressLabel.attributedText = mediaDescriptionForState;
        skMediaView.progressHolderView.hidden = NO;  // show progress
    } else {
        mediaIconForState = [self.skTwitterCollectionViewDataSource collectionView:self
                                                            mediaIconForMediaState:mediaState
                                                                      forItemAtRow:row
                                                               forMediaItemAtIndex:mediaIndex];
        
        if (mediaIconForState || mediaDescriptionForState) {
            [skMediaView.mediaIconButton setAttributedTitle:mediaDescriptionForState forState:UIControlStateNormal];
            [skMediaView.mediaIconButton setImage:mediaIconForState forState:UIControlStateNormal];
            skMediaView.mediaIconButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
            skMediaView.mediaIconButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
            skMediaView.mediaIconButton.hidden = NO;
        } else {
            skMediaView.mediaIconButton.hidden = YES;
        }
        
        skMediaView.progressHolderView.hidden = YES;  // hide progress
    }
}

- (void)renderMediaView:(SKTwitterMediaView *)skMediaView
      withMediaProgress:(NSProgress *)progress
{
    if (nil == skMediaView || nil == progress) return;
    
    skMediaView.circularProgressView.progress = progress.fractionCompleted;
}

@end
