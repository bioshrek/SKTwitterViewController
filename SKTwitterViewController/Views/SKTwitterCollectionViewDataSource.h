//
//  SKTwitterCollectionViewDataSource.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKTwitterAlbum.h"

@class SKTwitterCollectionView;
@class SKTwitterMediaCollectionView;

@protocol SKTwitterCollectionViewDataSource <UICollectionViewDataSource>

#pragma mark - Alum info

// number of albums sections
- (NSInteger)numberOfAlbumSectionsInCollectionView:(SKTwitterCollectionView *)collectionView;

// number of albums per section
- (NSInteger)collectionView:(SKTwitterCollectionView *)collectionView numberOfAlbumsInSection:(NSInteger)section;

// avator image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtIndexPath:(NSIndexPath *)indexPath;

// reply button image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView replyButtonImageForItemAtIndexPath:(NSIndexPath *)indexPath;

// album data
- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Media collection

// number of media sections
- (NSInteger)numberOfMediaSectionsForAlbumAtIndexPath:(NSIndexPath *)albumIndexPath;

// number of media items per section
- (NSInteger)numberOfMediaInSection:(NSInteger)section forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath;

// media cell
- (UICollectionViewCell *)collectionView:(SKTwitterMediaCollectionView *)collectionView mediaCellForItemAtIndexPath:(NSIndexPath *)indexPath;

// media cell size
- (CGSize)mediaDisplaySizeForMediaAtIndexPath:(NSIndexPath *)mediaIndexPath forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath;

#pragma mark - Footer view

- (BOOL)collectionView:(SKTwitterCollectionView *)collectionView shouldShowFooterViewInSection:(NSInteger)section;

- (NSAttributedString *)collectionView:(SKTwitterCollectionView *)collectionView footerViewAttributedTextInSection:(NSInteger)section;

@end
