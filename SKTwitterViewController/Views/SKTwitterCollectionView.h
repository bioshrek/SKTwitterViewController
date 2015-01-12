//
//  SKTwitterCollectionView.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTwitterTableLayout;

#import "SKTwitterCollectionViewDataSource.h"

#import "SKTwitterMediaView.h"
#import "SKTwitterMediaCollectionView.h"

@interface SKTwitterCollectionView : UICollectionView <SKTwitterMediaViewDelegate, SKTwitterMediaCollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SKTwitterTableLayout *collectionViewLayout;

@property (nonatomic, weak) id<SKTwitterCollectionViewDataSource> skTwitterCollectionViewDataSource;

@property (nonatomic, weak) SKTwitterMediaCollectionView *mediaCollectionViewForLayoutCalculation;

#pragma mark - Reusing media collection view

- (SKTwitterMediaCollectionView *)dequeueReusableMediaCollectionViewForItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Reusing media cell

- (void)registerNib:(UINib *)nib forMediaViewWithReuseIdentifier:(NSString *)identifier;

- (void)registerClass:(Class)cellClass forMediaViewWithReuseIdentifier:(NSString *)identifier;

// dequeue media view
- (SKTwitterMediaView *)dequeueReusableMediaViewWithReuseIdentifier:(NSString *)identifier
                                                       forItemAtRow:(NSUInteger)row
                                                      forMediaIndex:(NSUInteger)mediaIndex;

@end
