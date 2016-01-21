//
//  IIGalleryViewController.m
//  InstaImages
//
//  Created by Gumo on 15/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVPullToRefresh.h"
#import "UIScrollView+EmptyDataSet.h"

#import "IIGalleryViewController.h"
#import "IIGalleryCollectionViewCell.h"
#import "IIlnstagramFlowLayout.h"

#import "IIModelManager.h"

static NSString * const GALLERY_PLACEHOLDER_IMAGE_NAME = @"gallery_placeholder_photo";

@interface IIGalleryViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView * imagesCollectionView;
@property (strong, nonatomic) NSMutableArray<IIMediaModel*> * imageModelesArray;
@property (assign, nonatomic) BOOL emptyDataSetShouldDisplay;

@end

@implementation IIGalleryViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self initLayout];
    [self initImageCollection];
    [self loadImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initProperties {
    self.imageModelesArray = [NSMutableArray array];
    self.emptyDataSetShouldDisplay = NO;
    //    self.imagesCofillectionView.
}

-(void)initLayout {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)initImageCollection {
    self.imagesCollectionView.emptyDataSetSource = self;
    self.imagesCollectionView.emptyDataSetDelegate = self;
    self.imagesCollectionView.alwaysBounceVertical = YES;
    
    [self.imagesCollectionView addPullToRefreshWithActionHandler:^{
        NSString * maxMediaId = self.imageModelesArray[0].id;
        [[IIModelManager sharedManager] getNewerMediaForMinId:maxMediaId forUserWithId:self.userId completion:^(NSArray<IIMediaModel *> *media, IIError *error) {
            if (media) {
                NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndexesInRange: (NSRange){0, media.count}];
                [self insertNewMediaToCollectionView:media atIndexes:indexSet];
            }
            else if (error) {
                [self createErrorMessageWithError:error];
            }
            [self.imagesCollectionView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.imagesCollectionView addInfiniteScrollingWithActionHandler:^{
        NSString * maxMediaId = self.imageModelesArray[self.imageModelesArray.count -1].id;
        
        [[IIModelManager sharedManager] getOlderMediaForMaxId:maxMediaId forUserWithId:self.userId completion:^(NSArray<IIMediaModel *> *media, IIError *error) {
            if (media) {
                NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndexesInRange: (NSRange){self.imageModelesArray.count, media.count}];
                [self insertNewMediaToCollectionView:media atIndexes:indexSet];
            }
            else if (error) {
                [self createErrorMessageWithError:error];
            }
            [self.imagesCollectionView.infiniteScrollingView stopAnimating];
        }];
    }];
}

-(void)insertNewMediaToCollectionView:(NSArray<IIMediaModel*>*)media atIndexes:(NSIndexSet*)indexSet  {
    if (media.count > 0) {
        [self.imageModelesArray insertObjects:media atIndexes:indexSet];
        [self.imagesCollectionView performBatchUpdates:^{
            NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
            [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
                [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
            }];
            [self.imagesCollectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
        } completion:nil];
    }
}

- (void) loadImages {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self loadUserIsPrivateFlagWithCompletion:^(NSNumber *isPrivate, IIError *error) {
        if (error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self createErrorMessageWithError:error];
        }
        else if(isPrivate != nil) {
            if (isPrivate.boolValue) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self showEmptyDataSet];
            }
            else {
                [self loadImageLinksWithCompletion:^(NSArray<IIMediaModel *> *media, IIError *error) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    if (media) {
                        [self.imageModelesArray addObjectsFromArray:media];
                        [self.imagesCollectionView reloadData];
                    }
                    else if (error) {
                        [self createErrorMessageWithError:error];
                    }
                }];
            }
        }
    }];
}

-(void)loadUserIsPrivateFlagWithCompletion:(void(^)(NSNumber *isPrivate, IIError *error))completion{
    [[IIModelManager sharedManager] getUserIsPrivateFlagForUserWithUserId:self.userId completion:completion];
}

-(void)loadImageLinksWithCompletion:(void(^)(NSArray<IIMediaModel *> *media, IIError *error))completion {
    [[IIModelManager sharedManager] getLatestMediaForUserWithId:self.userId completion:completion];
}

-(void)showEmptyDataSet {
    self.emptyDataSetShouldDisplay = YES;
    [self.imagesCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.imageModelesArray.count;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IIGalleryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [self configureGalleryCell:cell forIndexPath:indexPath];
    return cell;
}

-(void)configureGalleryCell:(IIGalleryCollectionViewCell*) cell forIndexPath:(NSIndexPath *)indexPath {
    NSString * stringUrl = [self.imageModelesArray[indexPath.item] getThumbnailImageUrl];
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:GALLERY_PLACEHOLDER_IMAGE_NAME]];
}

#pragma mark - DZNEmptyDataSet DataSource&Delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This Account is Private";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Try another one.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.emptyDataSetShouldDisplay;
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
