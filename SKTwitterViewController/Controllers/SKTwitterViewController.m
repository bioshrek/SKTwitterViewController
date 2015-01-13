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

@interface SKTwitterViewController ()

@property (nonatomic, weak) IBOutlet SKTwitterCollectionView *collectionView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SKTwitterViewController

#pragma mark - nib

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SKTwitterViewController nib] instantiateWithOwner:self options:nil];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(SKTwitterCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSAssert(NO, @"subclass is required to override this method");
    return 0;
}

- (UICollectionViewCell *)collectionView:(SKTwitterCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [SKTwitterCollectionViewCell cellReuseIdentifier];
    SKTwitterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id<SKTwitterCollectionViewDataSource> dataSource = collectionView.skTwitterCollectionViewDataSource;
    
    // text view
    UIImage *avaTorImage = [dataSource collectionView:collectionView avatorImageForItemAtIndexPath:indexPath];
    UIImage *replyButtonImage = [dataSource collectionView:collectionView replyButtonImageForItemAtIndexPath:indexPath];
    id<SKTwitterAlbum> album = [dataSource collectionView:collectionView albumForItemAtIndexPath:indexPath];
    [self renderCell:cell avatorImage:avaTorImage replyButtonImage:replyButtonImage album:album];
    
    // media collection view
    cell.mediaCollectionView.albumIndexPath = indexPath;
    cell.mediaCollectionView.dataSource = collectionView;
    cell.mediaCollectionView.delegate = collectionView;
    [cell.mediaCollectionView reloadData];
    
    return cell;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(SKTwitterCollectionView *)collectionView
                  layout:(SKTwitterTableLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

#pragma mark - Cell rendering

// render album info, text
- (void)renderCell:(SKTwitterCollectionViewCell *)cell
       avatorImage:(UIImage *)avatorImage
  replyButtonImage:(UIImage *)replyButtonImage
             album:(id<SKTwitterAlbum>)album
{
    if (cell) {
        cell.avatorImageView.image = avatorImage;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
