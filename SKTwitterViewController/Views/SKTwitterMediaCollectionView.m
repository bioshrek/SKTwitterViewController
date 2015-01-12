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

- (id)init
{
    if (self = [super init]) {
        [self commonInitSKTwitterMediaCollectionView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInitSKTwitterMediaCollectionView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerNib:[SKTwitterMediaView nib] forCellWithReuseIdentifier:[SKTwitterMediaView reuseIdentifier]];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInitSKTwitterMediaCollectionView];
}

- (void)commonInitSKTwitterMediaCollectionView
{
    [self registerNib:[SKTwitterMediaView nib] forCellWithReuseIdentifier:[SKTwitterMediaView reuseIdentifier]];
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
    self.dataSource = nil;
    self.delegate = nil;
    [self.collectionViewLayout invalidateLayout];
}

@end
