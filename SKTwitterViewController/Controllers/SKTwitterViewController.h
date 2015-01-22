//
//  SKTwitterViewController.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKTwitterCollectionView.h"
#import "SKTwitterCollectionViewDataSource.h"
#import "SKTwitterCollectionViewDelegate.h"

@interface SKTwitterViewController : UIViewController <SKTwitterCollectionViewDataSource, SKTwitterCollectionViewDelegate>

@property (nonatomic, weak, readonly) SKTwitterCollectionView *collectionView;

- (UICollectionViewCell *)mediaCellForAlbumAtIndexPath:(NSIndexPath *)albumIndexPath forMediaAtIndexPath:(NSIndexPath *)mediaIndexPath;

@end
