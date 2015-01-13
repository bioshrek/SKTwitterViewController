//
//  SKTwitterTableLayout.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKTwitterCollectionView.h"




@interface SKTwitterTableLayout : UICollectionViewFlowLayout

@property (nonatomic, readonly) SKTwitterCollectionView *collectionView;

@property (readonly, nonatomic) CGFloat itemWidth;



/**
 *  Computes and returns the size of the item specified by indexPath.
 *
 *  @param indexPath The index path of the item to be displayed.
 *
 *  @return The size of the item displayed at indexPath.
 */
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;



@end
