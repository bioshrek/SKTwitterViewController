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
    
    [self registerNib:[SKTwitterCollectionViewCell nib]
forCellWithReuseIdentifier:[SKTwitterCollectionViewCell cellReuseIdentifier]];
}

@end
