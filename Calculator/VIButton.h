//
//  VIButton.h
//  Calculator
//
//  Created by Vlasov Illia on 24.06.14.
//  Copyright (c) 2014 vaisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIButton : NSObject
{
    SEL command;
    NSString *value;
    UIButton *button;
}

+ (NSMutableArray*)getButtons;

@property NSString *title;

- (id)initWithTitle:(NSString*)t andCommand:(SEL)sel;
- (id)initWithTitle:(NSString*)t command:(SEL)sel andValue:(NSString*)val;
- (void)execute;
- (void)setButton:(UIButton *)b;

@end
