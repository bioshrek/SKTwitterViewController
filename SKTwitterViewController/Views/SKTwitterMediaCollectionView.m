//
//  SKTwitterMediaCollectionView.m
//  SKTwitterViewControllerDemo
//
//  Created by shrek wang on 1/10/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterMediaCollectionView.h"

#import "SKTwitterMediaView.h"

@implementation SKTwitterMediaCollectionView

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerNib:[SKTwitterMediaView nib] forCellWithReuseIdentifier:[SKTwitterMediaView reuseIdentifier]];
        
    }
    return self;
}

#pragma mark - getter

- (NSMutableArray *)mediaCells
{
    if (!_mediaCells) {
        _mediaCells = [[NSMutableArray alloc] init];
    }
    return _mediaCells;
}

#pragma mark - reuse

- (void)prepareForReuse
{
    self.albumIndexPath = nil;
}

@end
