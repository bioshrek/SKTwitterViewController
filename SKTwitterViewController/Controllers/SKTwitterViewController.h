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

@interface SKTwitterViewController : UIViewController <SKTwitterCollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak, readonly) SKTwitterCollectionView *collectionView;

+ (UINib *)nib;

@end
