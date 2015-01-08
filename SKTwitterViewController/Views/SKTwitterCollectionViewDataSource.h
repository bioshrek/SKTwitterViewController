//
//  SKTwitterCollectionViewDataSource.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTwitterCollectionView;

@protocol SKTwitterCollectionViewDataSource <NSObject>

- (NSInteger)numberOfItemsInCollectionView:(SKTwitterCollectionView *)collectionView;


@end
