//
//  VIButton.m
//  Calculator
//
//  Created by Vlasov Illia on 24.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import "VIButton.h"
#import "VICalculator.h"

@implementation VIButton

@synthesize title;

static VICalculator *calculator = nil;



- (id)initWithTitle:(NSString *)t andCommand:(SEL)sel
{
    self = [super init];
    if (self) {
        title = t;
        command = sel;
        value = nil;
    }
    return self;
}


- (id)initWithTitle:(NSString *)t command:(SEL)sel andValue:(NSString*)val
{
    self = [super init];
    if (self) {
        title = t;
        command = sel;
        value = val;
    }
    return self;
}


+ (NSMutableArray*)getButtons
{
    static NSMutableArray *buttons;
    if (buttons == nil) {
        buttons = [[NSMutableArray alloc] initWithObjects:
                   [[VIButton alloc]initWithTitle:@"C" andCommand:@selector(clear)],
                   [[VIButton alloc]initWithTitle:@"+/-" andCommand:@selector(sign)],
                   [[VIButton alloc]initWithTitle:@"/" andCommand:@selector(divide)],
                   [[VIButton alloc]initWithTitle:@"." command:@selector(putValue) andValue:@"."],
                   [[VIButton alloc]initWithTitle:@"7" command:@selector(putValue) andValue:@"7"],
                   [[VIButton alloc]initWithTitle:@"8" command:@selector(putValue) andValue:@"8"],
                   [[VIButton alloc]initWithTitle:@"9" command:@selector(putValue) andValue:@"9"],
                   [[VIButton alloc]initWithTitle:@"*" andCommand:@selector(multiply)],
                   [[VIButton alloc]initWithTitle:@"4" command:@selector(putValue) andValue:@"4"],
                   [[VIButton alloc]initWithTitle:@"5" command:@selector(putValue) andValue:@"5"],
                   [[VIButton alloc]initWithTitle:@"6" command:@selector(putValue) andValue:@"6"],
                   [[VIButton alloc]initWithTitle:@"-" andCommand:@selector(minus)],
                   [[VIButton alloc]initWithTitle:@"1" command:@selector(putValue) andValue:@"1"],
                   [[VIButton alloc]initWithTitle:@"2" command:@selector(putValue) andValue:@"2"],
                   [[VIButton alloc]initWithTitle:@"3" command:@selector(putValue) andValue:@"3"],
                   [[VIButton alloc]initWithTitle:@"+" andCommand:@selector(plus)],
                   [[VIButton alloc]initWithTitle:@"0" command:@selector(putValue) andValue:@"0"],
                   [[VIButton alloc]initWithTitle:@"=" andCommand:@selector(calculate)],
                   nil];
        calculator = [VICalculator getCalculator];
    }
    return buttons;
}


- (void)setButton:(UIButton *)b
{
    if (button == nil) {
        button = b;
    } else {
        [button removeTarget:self action:@selector(execute) forControlEvents:UIControlEventTouchUpInside];
        button = b;
    }
    [button addTarget:self action:@selector(execute) forControlEvents:UIControlEventTouchUpInside];
}


- (void)clear
{
    [calculator clear];
}


- (void)sign
{
    [calculator sign];
}


- (void)minus
{
    [calculator minus];
}


- (void)plus
{
    [calculator plus];
}


- (void)multiply
{
    [calculator multiply];
}


- (void)divide
{
    [calculator divide];
}


- (void)putValue
{
    [calculator putValue:value];
}


- (void)calculate
{
    [calculator calculate];
}


- (void)execute
{
    [self performSelector:command];
}


@end
