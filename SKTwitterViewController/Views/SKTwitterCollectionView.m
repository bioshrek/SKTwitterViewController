//
//  SKTwitterCollectionView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionView.h"

#import "SKTwitterMediaView.h"
#import "SKTwitterCollectionViewCell.h"
#import "SKTwitterMediaCollectionViewFlowLayout.h"

@interface SKTwitterCollectionView ()

@end

@implementation SKTwitterCollectionView

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
}

#pragma mark - Media Collection view DataSource, delegate

- (NSInteger)collectionView:(SKTwitterMediaCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<SKTwitterAlbum> album = [self.skTwitterCollectionViewDataSource collectionView:self albumForItemAtIndexPath:collectionView.albumIndexPath];
    NSAssert(album, @"album should not be nil");
    
    return [album numberOfMediaInSection:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(SKTwitterMediaCollectionView *)collectionView
{
    id<SKTwitterAlbum> album = [self.skTwitterCollectionViewDataSource collectionView:self albumForItemAtIndexPath:collectionView.albumIndexPath];
    
    return [album numberOfMediaSections];
}

- (UICollectionViewCell *)collectionView:(SKTwitterMediaCollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [SKTwitterMediaView reuseIdentifier];
    SKTwitterMediaView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSAssert(cell, @"media cell can't be nil");
    
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtIndexPath:collectionView.albumIndexPath];
    NSAssert(album, @"album should not be nil");
    id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndexPath:indexPath];
    
    // media state
    SKMessageMediaState mediaState = [media mediaState];
    [self renderMediaView:cell media:media itemIndexPath:collectionView.albumIndexPath mediaIndexPath:indexPath];
    
    // media progress
    if (SKMessageMediaStateUploading == mediaState ||
        SKMessageMediaStateDownloading == mediaState) {
        [self renderMediaView:cell withMediaProgress:[media mediaProgress]];
    }
    
    // media thumbnail
    UIImage *thumbnail = [dataSource collectionView:self thumbnailForMediaState:mediaState forItemAtIndexPath:collectionView.albumIndexPath forMediaItemAtIndexPath:indexPath];
    cell.backgroundImageView.image = thumbnail;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4, 8, 4, 8);
}

- (CGSize)collectionView:(SKTwitterMediaCollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SKTwitterCollectionViewDataSource> dataSource = self.skTwitterCollectionViewDataSource;
    id<SKTwitterAlbum> album = [dataSource collectionView:self albumForItemAtIndexPath:collectionView.albumIndexPath];
    NSAssert(album, @"album should not be nil");
    id<SKTwitterAlbumMedia> media = [album albumMediaForItemAtIndexPath:indexPath];
    
    return [media mediaDisplaySize];
}

#pragma mark - render media view

- (void)renderMediaView:(SKTwitterMediaView *)skMediaView
                  media:(id<SKTwitterAlbumMedia>)media
          itemIndexPath:(NSIndexPath *)itemIndexPath
         mediaIndexPath:(NSIndexPath *)mediaIndexPath
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
                                                                forItemAtIndexPath:itemIndexPath
                                                           forMediaItemAtIndexPath:mediaIndexPath];
        
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
