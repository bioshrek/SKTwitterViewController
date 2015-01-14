//
//  SKTwitterViewController.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "SKTwitterViewController.h"

#import "SKTwitterTableLayout.h"
#import "SKTwitterCollectionViewCell.h"
#import "SKTwitterCollectionFooterView.h"

@interface SKTwitterViewController () <SKTwitterCollectionViewCellDelegate>

@property (nonatomic, weak) IBOutlet SKTwitterCollectionView *collectionView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SKTwitterViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInitSKTwitterViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)commonInitSKTwitterViewController
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.skTwitterCollectionViewDataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger n = 0;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterCollectionView *albumCollectionView = (SKTwitterCollectionView *)collectionView;
        n = [self collectionView:albumCollectionView numberOfAlbumsInSection:section];
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        n = [self numberOfMediaInSection:section forAlbumAtIndexPath:mediaCollectionView.albumIndexPath];
    }
    
    return n;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger n = 0;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterCollectionView *albumCollectionView = (SKTwitterCollectionView *)collectionView;
        n = [self numberOfAlbumSectionsInCollectionView:albumCollectionView];
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        n = [self numberOfMediaSectionsForAlbumAtIndexPath:mediaCollectionView.albumIndexPath];
    }
    
    return n;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterCollectionView *albumCollectionView = (SKTwitterCollectionView *)collectionView;
        cell = [self collectionView:albumCollectionView albumCellForItemAtIndexPath:indexPath];
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        cell = [self collectionView:mediaCollectionView mediaCellForItemAtIndexPath:indexPath];
        
        [self collectionView:mediaCollectionView willDisplayMediaCell:cell forMediaItemAtIndexPath:indexPath];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = nil;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]] && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[SKTwitterCollectionFooterView cellReuseIdentifier] forIndexPath:indexPath];
        SKTwitterCollectionFooterView *footerView = (SKTwitterCollectionFooterView *)view;
        SKTwitterCollectionView *albumCollectionView = (SKTwitterCollectionView *)collectionView;
        footerView.label.attributedText = [self collectionView:albumCollectionView footerViewAttributedTextInSection:indexPath.section];
        [footerView.activityIndicator startAnimating];
        
        [self collectionView:albumCollectionView willDisplayFooterView:footerView forAlbumInSection:indexPath.section];
    }
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterTableLayout *albumCollectionLayout = (SKTwitterTableLayout *)collectionViewLayout;
        size = [self collectionView:(SKTwitterCollectionView *)collectionView shouldShowFooterViewInSection:section] ?
            CGSizeMake([albumCollectionLayout itemWidth], kSKTwitterCollectionFooterViewHeight) :
            CGSizeZero;
    }

    return size;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(SKTwitterCollectionView *)collectionView
                  layout:(SKTwitterTableLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterTableLayout *albumCollectionLayout = (SKTwitterTableLayout *)collectionViewLayout;
        size = [albumCollectionLayout sizeForItemAtIndexPath:indexPath];
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        size = [self mediaDisplaySizeForMediaAtIndexPath:indexPath forAlbumAtIndexPath:mediaCollectionView.albumIndexPath];
    }
    
    return size;
}

#pragma mark - CollectionView Delegate

// selection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        SKTwitterCollectionView *albumCollectionView = (SKTwitterCollectionView *)collectionView;
        [self collectionView:albumCollectionView didSelectAlbumAtIndexPath:indexPath];
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        [self collectionView:mediaCollectionView didSelectMediaAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        // TODO:
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        [self collectionView:mediaCollectionView willDisplayMediaCell:cell forMediaItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        // TODO:
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        SKTwitterMediaCollectionView *mediaCollectionView = (SKTwitterMediaCollectionView *)collectionView;
        [self collectionView:mediaCollectionView didEndDisplayingMediaCell:cell forMediaItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isKindOfClass:[SKTwitterCollectionView class]]) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
            SKTwitterCollectionFooterView *footerView = (SKTwitterCollectionFooterView *)view;
            [footerView.activityIndicator stopAnimating];
        }
    } else if ([collectionView isKindOfClass:[SKTwitterMediaCollectionView class]]) {
        // TODO:
    }
}

#pragma mark - Cell rendering

// render album info, text
- (void)renderCell:(SKTwitterCollectionViewCell *)cell
       avatorImage:(UIImage *)avatorImage
  replyButtonImage:(UIImage *)replyButtonImage
             album:(id<SKTwitterAlbum>)album
{
    if (cell) {
        [cell.avatorButton setImage:avatorImage forState:UIControlStateNormal];
        cell.nameLabel.text = [album userName];
        
        // date
        cell.dateTimeLabel.text = [album dateText];
        
        [cell.replyButton setImage:replyButtonImage
                          forState:UIControlStateNormal];
        [cell.replyButton setTitle:[album replyButtonText]
                          forState:UIControlStateNormal];
        
        cell.textLabel.attributedText = [album attributedText];
    }
}

#pragma mark - SKTwitterCollectionView DataSource

// number of albums sections
- (NSInteger)numberOfAlbumSectionsInCollectionView:(SKTwitterCollectionView *)collectionView
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

// number of albums per section
- (NSInteger)collectionView:(SKTwitterCollectionView *)collectionView numberOfAlbumsInSection:(NSInteger)section
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

// avator image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return nil;
}

// reply button image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView replyButtonImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return nil;
}

// album data
- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return nil;
}

- (UICollectionViewCell *)collectionView:(SKTwitterCollectionView *)collectionView
             albumCellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [SKTwitterCollectionViewCell cellReuseIdentifier];
    SKTwitterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.albumIndexPath = indexPath;
    cell.delegate = self;
    
    id<SKTwitterCollectionViewDataSource> dataSource = collectionView.skTwitterCollectionViewDataSource;
    
    // text view
    UIImage *avaTorImage = [dataSource collectionView:collectionView avatorImageForItemAtIndexPath:indexPath];
    UIImage *replyButtonImage = [dataSource collectionView:collectionView replyButtonImageForItemAtIndexPath:indexPath];
    id<SKTwitterAlbum> album = [dataSource collectionView:collectionView albumForItemAtIndexPath:indexPath];
    [self renderCell:cell avatorImage:avaTorImage replyButtonImage:replyButtonImage album:album];
    
    // media collection view
    cell.mediaCollectionView.dataSource = self;
    cell.mediaCollectionView.delegate = self;
    [cell.mediaCollectionView reloadData];
    
    return cell;
}

- (BOOL)collectionView:(SKTwitterCollectionView *)collectionView shouldShowFooterViewInSection:(NSInteger)section
{
    NSAssert(NO, @"subclass is required to override this method");
    return NO;
}

- (NSAttributedString *)collectionView:(SKTwitterCollectionView *)collectionView footerViewAttributedTextInSection:(NSInteger)section
{
    NSAssert(NO, @"subclass is required to override this method");
    return nil;
}

#pragma mark - Media collection

// number of media sections
- (NSInteger)numberOfMediaSectionsForAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

// number of media items per section
- (NSInteger)numberOfMediaInSection:(NSInteger)section forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

// media cell
- (UICollectionViewCell *)collectionView:(SKTwitterMediaCollectionView *)collectionView mediaCellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return nil;
}

// media cell size
- (CGSize)mediaDisplaySizeForMediaAtIndexPath:(NSIndexPath *)mediaIndexPath forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    NSAssert(NO, @"subclass is required to override this method");
    return CGSizeZero;
}

#pragma mark - SKTwitterCollectionView Delegate

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView didSelectMediaAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectAvatorButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

- (void)collectionView:(SKTwitterCollectionView *)collectionView didSelectReplyButtonForAlbumAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

#pragma mark - SKTwitterCollectionViewCell Delegate

- (void)didSelectAvatorButtonInCollectionViewCell:(SKTwitterCollectionViewCell *)cell
{
    [self collectionView:self.collectionView didSelectAvatorButtonForAlbumAtIndexPath:cell.albumIndexPath];
}

- (void)didSelectReplyButtonInCollectionViewCell:(SKTwitterCollectionViewCell *)cell
{
    [self collectionView:self.collectionView didSelectReplyButtonForAlbumAtIndexPath:cell.albumIndexPath];
}

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView willDisplayMediaCell:(UICollectionViewCell *)cell forMediaItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

- (void)collectionView:(SKTwitterMediaCollectionView *)collectionView didEndDisplayingMediaCell:(UICollectionViewCell *)cell forMediaItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: subclass override
}

- (void)collectionView:(SKTwitterCollectionView *)collectionView willDisplayFooterView:(UICollectionReusableView *)footerView forAlbumInSection:(NSInteger)section
{
    // TODO: subclass override
}

#pragma mark - Access media cell

- (UICollectionViewCell *)mediaCellForAlbumAtIndexPath:(NSIndexPath *)albumIndexPath forMediaAtIndexPath:(NSIndexPath *)mediaIndexPath
{
    SKTwitterCollectionViewCell *albumCollectionViewCell = (SKTwitterCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:albumIndexPath];
    return [albumCollectionViewCell.mediaCollectionView cellForItemAtIndexPath:mediaIndexPath];
}

@end
