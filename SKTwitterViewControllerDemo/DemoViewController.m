//
//  ViewController.m
//  SKTwitterViewControllerDemo
//
//  Created by Shrek Wang on 1/8/15.
//  Copyright (c) 2015 Shrek. All rights reserved.
//

#import "DemoViewController.h"

#import "SKTwitterAlbumShareItem.h"
#import "SKTwitterAlbumCommentItem.h"
#import "SKTwitterAlbumMediaViewSquareStyle.h"
#import "SKTwitterAlbumMediaViewRectangleStyle.h"

@interface DemoViewController () <SKTwitterCollectionViewDataSource>

@property (nonatomic, strong) SKTwitterAlbumShareItem *album;

@property (nonatomic, strong) NSMutableArray *commentList;

@end

@implementation DemoViewController

#pragma mark - getter

- (NSMutableArray *)commentList
{
    if (!_commentList) {
        _commentList = [[NSMutableArray alloc] init];
    }
    return _commentList;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.skTwitterCollectionViewDataSource = self;
    
    // register media cell
    
    // get sample data
    self.album = [self sampleAlbum];
    [self.commentList addObject:[self sampleComment]];
    [self.commentList addObject:[self sampleComment]];
    
    
    
    
}

- (id<SKTwitterAlbum>)sampleAlbum
{
    NSArray *mediaItems1 = @[
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                             mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                             mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                             [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(70, 70)
                                                                                mediaState:SKMessageMediaStateToBeDownloaded
                                                                   mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Share your moments.txt"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                   mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]]
                             ];
    NSArray *mediaItem2 = @[
                            [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                               mediaState:SKMessageMediaStateToBeDownloaded
                                                            mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"lucky day.txt"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                            mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"16.8 KB"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                            [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                               mediaState:SKMessageMediaStateToBeDownloaded
                                                            mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Your are sunshine.mp4"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                            mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"4.6 MB"
                                                                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]],
                            [[SKTwitterAlbumMediaDataItem alloc] initWithMediaDisplaySize:CGSizeMake(210, 150)
                                                                               mediaState:SKMessageMediaStateToBeDownloaded
                                                                  mediaNameAttributedText:[[NSAttributedString alloc] initWithString:@"Your are sunshine.mp4"
                                                                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                                                  mediaSizeAttributedText:[[NSAttributedString alloc] initWithString:@"4.6 MB"
                                                                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}]]
                            ];
    
    return [[SKTwitterAlbumShareItem alloc] initWithUserName:@"shrek"
                                                    dateText:@"2015-1-13 2:59 P.M."
                                             replyButtonText:@"10"
                                              attributedText:[[NSAttributedString alloc] initWithString:@"hello, nice day!" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]
                                               mediaSections:@[
                                                             mediaItems1,
                                                             mediaItem2
                                                             ]];
}

- (id<SKTwitterAlbum>)sampleComment
{
    return [[SKTwitterAlbumCommentItem alloc] initWithUserName:@"shrek 2"
                                                      dateText:@"2015-1-13 2:59 P.M."
                                                attributedText:[[NSAttributedString alloc] initWithString:@"This is an important point when it comes to the design phase of your adaptive layout. You should build a base layout first and then customize each specific size class based on the individual needs of that size class. Don’t treat each of the size classes as a completely separate design. Think of an adaptive layout as a hierarchy, in which you put all of the shared design into the parent and then make any necessary changes in the child size classes." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]];
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

// number of albums sections
- (NSInteger)numberOfAlbumSectionsInCollectionView:(SKTwitterCollectionView *)collectionView
{
    return 2;
}

// number of albums per section
- (NSInteger)collectionView:(SKTwitterCollectionView *)collectionView numberOfAlbumsInSection:(NSInteger)section
{
    NSInteger numberOfItemsInSection = 0;
    
    switch (section) {
        case 0: {
            numberOfItemsInSection = 1;
        } break;
        case 1: {
            numberOfItemsInSection = [self.commentList count];
        } break;
        default:
            break;
    }
    
    return numberOfItemsInSection;
}

// avator image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView avatorImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIImage imageNamed:@"default_avator"];
}

// reply button image
- (UIImage *)collectionView:(SKTwitterCollectionView *)collectionView replyButtonImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *replyButtonImage = nil;
    
    switch (indexPath.section) {
        case 0: {
            replyButtonImage = [UIImage imageNamed:@"reply"];
        } break;
        case 1: {
            replyButtonImage = nil;
        } break;
        default:
            break;
    }
    
    return replyButtonImage;
}

// album data
- (id<SKTwitterAlbum>)collectionView:(SKTwitterCollectionView *)collectionView albumForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SKTwitterAlbum> album = nil;
    
    switch (indexPath.section) {
        case 0: {
            album = self.album;
        } break;
        case 1: {
            album = [self.commentList objectAtIndex:indexPath.item];
        } break;
        default:
            break;
    }
    
    return album;
}

// number of media sections
- (NSInteger)numberOfMediaSectionsForAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    NSInteger n = 0;
    
    switch (albumIndexPath.section) {
        case 0: {
            n = [self.album numberOfMediaSections];
        } break;
        case 1: {
            n = 0;
        } break;
        default:
            break;
    }
    
    return n;
}

// number of media items per section
- (NSInteger)numberOfMediaInSection:(NSInteger)section forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    NSInteger n = 0;
    
    switch (albumIndexPath.section) {
        case 0: {
            n = [self.album numberOfMediaInSection:section];
        } break;
        case 1: {
            n = 0;
        } break;
        default: break;
    }
    
    return n;
}

// media cell
- (UICollectionViewCell *)collectionView:(SKTwitterMediaCollectionView *)collectionView mediaCellForItemAtIndexPath:(NSIndexPath *)mediaIndexPath
{
    // register media prototype
    [collectionView registerNib:[SKTwitterAlbumMediaViewSquareStyle nib]
     forCellWithReuseIdentifier:[SKTwitterAlbumMediaViewSquareStyle reuseIdentifier]];
    [collectionView registerNib:[SKTwitterAlbumMediaViewRectangleStyle nib]
     forCellWithReuseIdentifier:[SKTwitterAlbumMediaViewRectangleStyle reuseIdentifier]];
    
    UICollectionViewCell *cell = nil;
    NSIndexPath *albumIndexPath = collectionView.albumIndexPath;
    switch (albumIndexPath.section) {
        case 0: {
            SKTwitterAlbumMediaDataItem *mediaItem = [self.album albumMediaForItemAtIndexPath:mediaIndexPath];
            switch (mediaIndexPath.section) {
                case 0: {
                    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SKTwitterAlbumMediaViewSquareStyle reuseIdentifier] forIndexPath:mediaIndexPath];
                } break;
                case 1: {
                    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SKTwitterAlbumMediaViewRectangleStyle reuseIdentifier] forIndexPath:mediaIndexPath];
                } break;
                default: break;
            }
            
            NSAssert(cell, @"media cell can't be nil");
            [self renderMediaCell:(SKTwitterAlbumMediaView *)cell withMediaItem:mediaItem];
        } break;
        default:
            break;
    }
    
    return cell;
}

- (void)renderMediaCell:(SKTwitterAlbumMediaView *)cell withMediaItem:(SKTwitterAlbumMediaDataItem *)mediaItem
{
    SKMessageMediaState mediaState = [mediaItem mediaState];
    
    if (SKMessageMediaStateUploading == mediaState ||
        SKMessageMediaStateDownloading == mediaState) {
        
        [cell setProgressViewVisible:YES];
        [cell updateProgress:[mediaItem mediaProgress].fractionCompleted];
    } else {
        [cell setProgressViewVisible:NO];
    }
    
    [cell setMediaNameAttributedText:[mediaItem mediaNameAttributedText]];
    [cell setMediaSizeAttributedText:[mediaItem mediaSizeAttributedText]];
}

// media cell size
- (CGSize)mediaDisplaySizeForMediaAtIndexPath:(NSIndexPath *)mediaIndexPath forAlbumAtIndexPath:(NSIndexPath *)albumIndexPath
{
    CGSize size = CGSizeZero;

    switch (albumIndexPath.section) {
        case 0: {
            switch (mediaIndexPath.section) {
                case 0: {
                    size = CGSizeMake(70, 70);
                } break;
                case 1: {
                    size = CGSizeMake(250, 44);
                } break;
                default: break;
            }
        } break;
        default:
            break;
    }
    
    return size;
}

@end
