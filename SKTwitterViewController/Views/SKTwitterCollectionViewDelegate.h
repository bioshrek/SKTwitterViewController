//
//  SKTwitterCollectionViewDelegate.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/14/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTwitterCollectionView;
@class SKTwitterMediaCollectionView;

@protocol SKTwitterCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

#pragma mark - Selection

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView didSelectMediaAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAvatorButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectReplyButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterCollectionView *)collectionView willDisplayFooterView:(UICollectionReusableView *)footerView forAlbumInSection:(NSInteger)section;

#pragma mark - Tracking Displaying of media cell

// only work in iOS 8 and later
- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView willDisplayMediaCell:(UICollectionViewCell *)cell forMediaItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView didEndDisplayingMediaCell:(UICollectionViewCell *)cell forMediaItemAtIndexPath:(NSIndexPath *)indexPath;



@end
