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

#pragma mark - getter

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return _dateFormatter;
}

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
    return [collectionView.skTwitterCollectionViewDataSource numberOfItemsInCollectionView:collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(SKTwitterCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [SKTwitterCollectionViewCell cellReuseIdentifier];
    SKTwitterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id<SKTwitterCollectionViewDataSource> dataSource = collectionView.skTwitterCollectionViewDataSource;
    NSInteger row = indexPath.item;
    
    // text view
    UIImage *avaTorImage = [dataSource collectionView:collectionView avatorImageForItemAtRow:row];
    id<SKTwitterAlbum> album = [dataSource collectionView:collectionView albumForItemAtRow:row];
    [self renderCell:cell avatorImage:avaTorImage album:album];
    
    // TODO:
    
    return cell;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(SKTwitterCollectionView *)collectionView
                  layout:(SKTwitterTableLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

#pragma mark - Cell rendering

// render user info
- (void)renderCell:(SKTwitterCollectionViewCell *)cell
       avatorImage:(UIImage *)avatorImage
             album:(id<SKTwitterAlbum>)album
{
    if (cell) {
        cell.avatorImageView.image = avatorImage;
        cell.nameLabel.text = [album userName];
        
        // date
        cell.dateTimeLabel.text = [self.dateFormatter stringFromDate:[album date]];
        
        NSUInteger replyCount = [album replyCount];
        [cell.replyButton setTitle:replyCount ? [NSString stringWithFormat:@"%d", (int)replyCount] : @""
                          forState:UIControlStateNormal];
        
        cell.textView.attributedText = [album attributedText];
        
        // TODO: media collection view
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
