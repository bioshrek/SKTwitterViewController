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


#import "SKTwitterMediaCollectionView.h"

@interface SKTwitterCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SKTwitterTableLayout *collectionViewLayout;

@property (nonatomic, weak) id<SKTwitterCollectionViewDataSource> skTwitterCollectionViewDataSource;

@end
