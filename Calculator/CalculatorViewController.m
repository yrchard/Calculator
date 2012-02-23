//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Richard Nutley on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userHasAlreadyEnteredDecimal;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize ticker = _ticker;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize userHasAlreadyEnteredDecimal = _userHasAlreadyEnteredDecimal;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (void)updateTicker:(NSString *)newElementToAddToTicker
{
    if(newElementToAddToTicker) {
        if (self.ticker.text.length > 26) { //if longer than 26, cut down to size
            self.ticker.text = [self.ticker.text substringFromIndex:self.ticker.text.length - 27];
        }
        //now add the new element
        self.ticker.text = [self.ticker.text stringByAppendingString:newElementToAddToTicker];
        self.ticker.text = [self.ticker.text stringByAppendingString:@" "];
    }
    //clear ticker if newElementToAddToTicker is "C"
    if([newElementToAddToTicker isEqualToString:@"C"]) {
        self.ticker.text = @"";
    }
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }    
}

- (IBAction)decimalPressed
{
    if (!self.userHasAlreadyEnteredDecimal) {
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:@"."];
        } else {
            self.display.text = @"0.";
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
        self.userHasAlreadyEnteredDecimal = YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self updateTicker:self.display.text];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasAlreadyEnteredDecimal = NO;
}

- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    [self updateTicker:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
