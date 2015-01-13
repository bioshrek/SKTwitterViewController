//
//  SKTwitterTableLayoutAttributes.h
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - layout constants

@interface SKTwitterTableLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

@property (assign, nonatomic) CGFloat textViewHeight;
@property (assign, nonatomic) CGFloat mediaCollectionHolderViewHeight;
@property (assign, nonatomic) BOOL shouldContentIndent;

@end
