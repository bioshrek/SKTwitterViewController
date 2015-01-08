//
//  ViewController.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController () <SKTwitterCollectionViewDataSource>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.skTwitterCollectionViewDataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SKTwitterCollectionView DataSource

- (NSInteger)numberOfItemsInCollectionView:(SKTwitterCollectionView *)collectionView
{
    return 10;
}

@end
