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

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView didSelectMediaAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAvatorButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectReplyButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath;

@end
