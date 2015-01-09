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

#pragma mark - Collection info

- (NSInteger)numberOfItemsInCollectionView:(SKTwitterCollectionView *)collectionView;


#pragma mark - Alum info

// avator image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtRow:(NSUInteger)row;

// album
- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtRow:(NSUInteger)row;

#pragma mark - Media collection

// media icon for states
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     mediaIconForMediaState:(SKMessageMediaState)mediaState
               forItemAtRow:(NSUInteger)row
        forMediaItemAtIndex:(NSUInteger)index;

// media thumbnail
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     thumbnailForMediaState:(SKMessageMediaState)mediaState
               forItemAtRow:(NSUInteger)row
        forMediaItemAtIndex:(NSUInteger)index;

@end
