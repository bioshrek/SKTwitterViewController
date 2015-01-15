//
//  SKTwitterCollectionView.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterCollectionView.h"

#import "SKTwitterMediaView.h"
#import "SKTwitterCollectionViewCell.h"
#import "SKTwitterMediaCollectionViewFlowLayout.h"
#import "SKTwitterCollectionHeaderView.h"
#import "SKTwitterCollectionFooterView.h"

@interface SKTwitterCollectionView ()

@end

@implementation SKTwitterCollectionView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInitSKTwitterCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitSKTwitterCollectionView];
}

- (void)commonInitSKTwitterCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    // register cell prototype
    [self registerNib:[SKTwitterCollectionViewCell nib]
forCellWithReuseIdentifier:[SKTwitterCollectionViewCell cellReuseIdentifier]];
    
    // register footer view prototype
    [self registerNib:[SKTwitterCollectionFooterView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[SKTwitterCollectionFooterView cellReuseIdentifier]];
    
    // register header view prototype
    [self registerNib:[SKTwitterCollectionHeaderView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SKTwitterCollectionHeaderView cellReuseIdentifier]];
}



@end
