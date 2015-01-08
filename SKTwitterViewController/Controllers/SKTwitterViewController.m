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
    
    // TODO:
    
    return cell;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(SKTwitterCollectionView *)collectionView
                  layout:(SKTwitterTableLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
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
