//
//  VICalculator.h
//  Calculator
//
//  Created by Vlasov Illia on 25.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VICalculatorDelegate <NSObject>

- (void)calculatorDataUpdated;

@end

@interface VICalculator : NSObject
{
    NSString *firstValue;
    NSString *secondValue;
    bool signedValue;
    bool commandEntered;
    bool dataCalculated;
    bool pointEntered;
}


+ (VICalculator*)getCalculator;

@property NSString *currentValue;

@property (nonatomic, weak) id <VICalculatorDelegate> delegate;


- (void)clear;
- (void)sign;
- (void)minus;
- (void)plus;
- (void)multiply;
- (void)divide;
- (void)putValue:(NSString*)value;
- (void)calculate;

@end
