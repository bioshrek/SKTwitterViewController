//
//  ViewController.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "DemoViewController.h"

#import "SKTwitterAlbumDataItem.h"

@interface DemoViewController () <SKTwitterCollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *albumList;

@end

@implementation DemoViewController

#pragma mark - getter

- (NSMutableArray *)albumList
{
    if (!_albumList) {
        _albumList = [[NSMutableArray alloc] init];
    }
    return _albumList;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.skTwitterCollectionViewDataSource = self;
    
    // get sample data
    [self.albumList setArray:[self sampleData]];
}

- (NSArray *)sampleData
{
    NSArray *mediaItems1 = @[
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                             mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                             mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                             mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Your are beatutiful.mp3"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                             mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"4.6 MB"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]]
                             ];
    NSArray *mediaItem2 = @[
                            [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                               mediaState:SKMessageMediaStateToBeDownloaded
                                                            mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                            mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                            [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                               mediaState:SKMessageMediaStateToBeDownloaded
                                                            mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Your are beatutiful.mp3"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                            mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"4.6 MB"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]]
                            ];
    
    return @[
                [[SKTwitterAlbumDataItem alloc] initWithUseName:@"shrek"
                                                           date:[NSDate date]
                                                     replyCount:5
                                                 attributedText:[[NSAttributedString alloc] initWithString:@"hello, nice day!" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                     mediaItems:mediaItems1],
                [[SKTwitterAlbumDataItem alloc] initWithUseName:@"shrek 2"
                                                           date:[NSDate date]
                                                     replyCount:20
                                                 attributedText:[[NSAttributedString alloc] initWithString:@"This is an important point when it comes to the design phase of your adaptive layout. You should build a base layout first and then customize each specific size class based on the individual needs of that size class. Don’t treat each of the size classes as a completely separate design. Think of an adaptive layout as a hierarchy, in which you put all of the shared design into the parent and then make any necessary changes in the child size classes." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                     mediaItems:mediaItem2]
             ];
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
    return [self.albumList count];
}

- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtRow:(NSUInteger)row
{
    // TODO:
    return [UIImage imageNamed:@"default_avator"];
}

- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtRow:(NSUInteger)row
{
    return [self.albumList objectAtIndex:row];
}

// media icon for states
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     mediaIconForMediaState:(SKMessageMediaState)mediaState
         forItemAtRow:(NSUInteger)row
        forMediaItemAtIndex:(NSUInteger)index
{
    // TODO:
    return nil;
}

// media thumbnail
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView
     thumbnailForMediaState:(SKMessageMediaState)mediaState
         forItemAtRow:(NSUInteger)row
        forMediaItemAtIndex:(NSUInteger)index
{
    // TODO:
    return nil;
}

@end
