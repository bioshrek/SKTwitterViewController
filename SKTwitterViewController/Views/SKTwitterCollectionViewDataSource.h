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

@protocol SKTwitterCollectionViewDataSource <NSObject>

#pragma mark - Alum info

// avator image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtIndexPath:(NSIndexPath *)indexPath;

// reply button image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView replyButtonImageForItemAtIndexPath:(NSIndexPath *)indexPath;

// album
- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Media collection

// media icon for states
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     mediaIconForMediaState:(SKMessageMediaState)mediaState
         forItemAtIndexPath:(NSIndexPath *)itemIndexPath
    forMediaItemAtIndexPath:(NSIndexPath *)mediaIndexPath;

// media thumbnail
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     thumbnailForMediaState:(SKMessageMediaState)mediaState
         forItemAtIndexPath:(NSIndexPath *)itemIndexPath
    forMediaItemAtIndexPath:(NSIndexPath *)mediaIndexPath;

@end
