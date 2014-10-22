//
//  VICollectionViewController.m
//  Calculator
//
//  Created by Vlasov Illia on 24.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import "VICollectionViewController.h"
#import "VIButtonCell.h"
#import "VICollectionHeaderView.h"


@implementation VICollectionViewController


static VICalculator *calculator = nil;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    buttons = [VIButton getButtons];
    cellWidth = self.collectionView.frame.size.width / 4;
    cellHeight = (self.collectionView.frame.size.height - 108) / 5;
    calculator = [VICalculator getCalculator];
    [calculator setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return buttons.count;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VIButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ButtonCellId" forIndexPath:indexPath];
    VIButton *button = [buttons objectAtIndex:[indexPath row]];
    [button setButton:cell.button];
    [cell.button setTitle:[button title] forState:UIControlStateNormal];
    [[cell.button layer]setBorderWidth:1];
    [[cell.button layer]setBorderColor:[UIColor redColor].CGColor];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int width = cellWidth;
    if (indexPath.row == buttons.count - 2) {
        width *= 3;
    }
    return CGSizeMake(width, cellHeight);
}


- (void)calculatorDataUpdated
{
    headerView.outputLabel.text = calculator.currentValue;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewId" forIndexPath:indexPath];
        headerView.outputLabel.text = calculator.currentValue;
        reusableview = headerView;
    }
    
    return reusableview;
}



-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    cellWidth = self.collectionView.frame.size.width / 4;
    cellHeight = (self.collectionView.frame.size.height - 108) / 5;
    [[self collectionView] reloadData];
}

@end
