//
//  VICollectionViewController.h
//  Calculator
//
//  Created by Vlasov Illia on 24.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIButton.h"
#import "VICalculator.h"

@class VICollectionHeaderView;

@interface VICollectionViewController : UICollectionViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VICalculatorDelegate>
{
    NSMutableArray *buttons;
    int cellWidth;
    int cellHeight;
    VICollectionHeaderView *headerView;
}

@end
