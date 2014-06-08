//
//  LevelUpPaymentViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/8/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "LevelUpPaymentViewController.h"
#import "TipCollectionViewCell.h"

@interface LevelUpPaymentViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *tipsCollectionView;
@property (assign, nonatomic) NSInteger activeTip;
@property (strong, nonatomic) NSArray *QRCodeImages;
@end

@implementation LevelUpPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationIcon"]];

    [self.tipsCollectionView registerNib:[UINib nibWithNibName:@"TipCollectionViewCell"
                                                        bundle:[NSBundle mainBundle]]
              forCellWithReuseIdentifier:@"TipCollectionViewCell"];
    
    [self.tipsCollectionView registerClass:[UICollectionReusableView class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                       withReuseIdentifier:@"FooterView"];

    self.QRCodeImages = @[
                          [UIImage imageNamed:@"levelup_1"],
                          [UIImage imageNamed:@"levelup_2"],
                          [UIImage imageNamed:@"levelup_3"],
                          [UIImage imageNamed:@"levelup_4"],
                          ];

    [self updateForSelection:0];
}

- (void)updateForSelection:(NSInteger)tip {
    self.activeTip = tip;
    [self.tipsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.activeTip inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    self.QRCodeImageView.image = self.QRCodeImages[tip % self.QRCodeImages.count];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TipCollectionViewCell *cell = (TipCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"TipCollectionViewCell"
                                                                                                     forIndexPath:indexPath];
    cell.tipAmountLabel.text = [NSString stringWithFormat:@"%ld", (long)(indexPath.row * 5)];
    cell.selected = indexPath.row == self.activeTip;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor clearColor];

        reusableview = footerview;
    }

    return reusableview;
}

#pragma mark - UICollectionViewDelegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.activeTip = indexPath.row;

    [self.tipsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    [self updateForSelection:self.activeTip];
}

#pragma mark - UIScrollViewDelegate Methods

- (NSIndexPath *)indexPathToSelect {
    CGPoint origin = CGPointMake(76, self.view.bounds.size.height - 1);
    NSIndexPath *path = [self.tipsCollectionView indexPathForItemAtPoint:[self.tipsCollectionView convertPoint:origin
                                                                                                      fromView:self.view]];
    return path;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *path = [self indexPathToSelect];
    if (self.activeTip != path.row) {
        [self updateForSelection:path.row];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        NSIndexPath *indexPath = [self indexPathToSelect];
        self.activeTip = indexPath.row;
        [self.tipsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [self updateForSelection:self.activeTip];

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self indexPathToSelect];
    self.activeTip = indexPath.row;
    [self.tipsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self updateForSelection:self.activeTip];
}

@end
