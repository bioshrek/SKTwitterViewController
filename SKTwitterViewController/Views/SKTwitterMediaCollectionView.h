//
//  SKTwitterMediaCollectionView.h
//  SKTwitterViewControllerDemo
//
//  Created by shrek wang on 1/10/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTwitterMediaCollectionView;

@protocol SKTwitterMediaCollectionViewDelegate <NSObject>

- (void)recycleMediaCollectionView:(SKTwitterMediaCollectionView *)mediaCollectionView;

@end

@interface SKTwitterMediaCollectionView : UICollectionView

@property (nonatomic, copy) NSIndexPath *albumIndexPath;

@property (nonatomic, weak) id<SKTwitterMediaCollectionViewDelegate> mediaCollectionViewDelegate;

@property (nonatomic, strong) NSMutableArray *mediaCells;

- (void)prepareForReuse;

@end
