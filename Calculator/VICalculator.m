//
//  VICalculator.m
//  Calculator
//
//  Created by Vlasov Illia on 25.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import "VICalculator.h"

typedef enum {
    NONE,
    MINUS_COMMAND,
    PLUS_COMMAND,
    MULTIPLY_COMMAND,
    DIVIDE_COMMAND,
} CommandType;

@interface VICalculator()
{
    CommandType currentCommand;
}

@end

@implementation VICalculator

@synthesize currentValue, delegate;

static NSString *ZERO_DEVISION_ERROR = @"You can not divide by zero!";


+ (VICalculator*)getCalculator
{
    static VICalculator *calculator = nil;
    if (calculator == nil) {
        calculator = [[VICalculator alloc] init];
    }
    return calculator;
}


- (id)init
{
    self = [super init];
    if (self) {
        [self clear];
    }
    return self;
}


- (NSNumber*)getNumberValue:(NSString*)value
{
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [numberFormatter numberFromString:value];
}



- (void)clear
{
    currentValue = @"0";
    firstValue = @"";
    secondValue = @"";
    signedValue = false;
    commandEntered = false;
    dataCalculated = false;
    currentCommand = NONE;
    pointEntered = false;
    [delegate calculatorDataUpdated];
}


- (void)sign
{
    if ([currentValue isEqualToString:@"0"]) {
        //show error
        return;
    }
    currentValue = signedValue ? [currentValue substringWithRange:NSMakeRange(1, [currentValue length]-1)] : [NSString stringWithFormat:@"-%@", currentValue];
    signedValue = !signedValue;
    [delegate calculatorDataUpdated];
}


- (void)prepareForCommand
{
    commandEntered = true;
    if ([firstValue length] != 0) {
        [self executeCurrentCommand];
    }
}


- (void)minus
{
    [self prepareForCommand];
    currentCommand = MINUS_COMMAND;
}


- (void)plus
{
    [self prepareForCommand];
    currentCommand = PLUS_COMMAND;
}


- (void)multiply
{
    [self prepareForCommand];
    currentCommand = MULTIPLY_COMMAND;
}


- (void)divide
{
    [self prepareForCommand];
    currentCommand = DIVIDE_COMMAND;
}


- (void)putValue:(NSString*)value
{
    if (dataCalculated && !commandEntered) {
        [self clear];
    }
    if ([value isEqualToString:@"."]) {
        if (pointEntered) {
            return;
        } else {
            pointEntered = true;
        }
    }
    if (commandEntered) {
        commandEntered = false;
        firstValue = currentValue;
        secondValue = @"";
        currentValue = @"0";
        signedValue = false;
        pointEntered = false;
    }
    if ([currentValue isEqualToString:@"0"]) {
        currentValue = value;
    } else {
        currentValue = [currentValue stringByAppendingString:value];
    }
    [delegate calculatorDataUpdated];
}


- (void)alertWithText:(NSString*)alertText
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:
                          alertText delegate:nil cancelButtonTitle:
                          @"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)executeCurrentCommand
{
    bool firstValueEmpty = [firstValue length] == 0;
    bool secondValueEmpty = [secondValue length] == 0;
    if (secondValueEmpty) {
        secondValue = currentValue;
    }
    bool currentValueIsZero = [currentValue isEqualToString:@"0"];
    double currentNumber = [currentValue doubleValue];
    double firstNumber = [firstValue doubleValue];
    double secondNumber = [secondValue doubleValue];
    switch (currentCommand) {
        case MINUS_COMMAND:
            if (firstValueEmpty && !currentValueIsZero) {
                currentNumber -= secondNumber;
            } else if (!firstValueEmpty) {
                currentNumber = firstNumber - currentNumber;
            }
            break;
        case PLUS_COMMAND:
            if (firstValueEmpty && !currentValueIsZero) {
                currentNumber += secondNumber;
            } else if (!firstValueEmpty) {
                currentNumber = firstNumber + currentNumber;
            }
            break;
        case DIVIDE_COMMAND:
            if (firstValueEmpty && !currentValueIsZero) {
                if (secondNumber == 0) {
                    [self alertWithText:ZERO_DEVISION_ERROR];
                } else {
                    currentNumber /= secondNumber;
                }
            } else if (!firstValueEmpty) {
                if (currentNumber == 0) {
                    [self alertWithText:ZERO_DEVISION_ERROR];
                } else {
                    currentNumber = firstNumber / currentNumber;
                }
            }
            break;
        case MULTIPLY_COMMAND:
            if (firstValueEmpty && !currentValueIsZero) {
                currentNumber *= secondNumber;
            } else if (!firstValueEmpty) {
                currentNumber = firstNumber * currentNumber;
            }
            break;
            
        default:
            break;
    }
    signedValue = currentNumber < 0;
    firstValue = @"";
    currentValue = [NSString stringWithFormat:@"%g", currentNumber];
    [delegate calculatorDataUpdated];
}


- (void)calculate
{
    [self executeCurrentCommand];
    commandEntered = false;
    dataCalculated = true;
}

@end
