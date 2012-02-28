//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Richard Nutley on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  "Delete this comment. 2/28/12"

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;
+ (NSSet *)variablesUsedInProgram:(id)program;

@end
