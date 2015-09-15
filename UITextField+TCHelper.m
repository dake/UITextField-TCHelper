//
//  UITextField+TCHelper.m
//  Dake
//
//  Created by Dake on 15/9/15.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import "UITextField+TCHelper.h"
#import <objc/runtime.h>


@interface TCTextFieldTarget : NSObject

+ (void)textFieldEditChanged:(UITextField *)textField;

@end


@implementation TCTextFieldTarget

+ (void)textFieldEditChanged:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = textField.markedTextRange;
    // check highlight selection position
    UITextPosition *position = nil;
    if (nil != selectedRange) {
        position = [textField positionFromPosition:selectedRange.start offset:0];
    }
    // no highlight selection
    if (nil == position) {
        NSInteger maxLength = textField.tc_maxTextLength;
        
        if (maxLength >= 0 && toBeString.length > maxLength) {
            NSRange range = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            textField.text = [toBeString substringToIndex:range.location == NSNotFound ? maxLength : range.location];
        }
    }
    else {
    }
}

@end


@implementation UITextField (TCHelper)

- (NSInteger)tc_maxTextLength
{
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return nil == value ? -1 : value.integerValue;
}

- (void)setTc_maxTextLength:(NSInteger)tc_maxTextLength
{
    objc_setAssociatedObject(self, @selector(tc_maxTextLength), @(tc_maxTextLength), OBJC_ASSOCIATION_RETAIN);
    
    id target = (id)TCTextFieldTarget.class;
    if (![self.allTargets containsObject:target]) {
        [self addTarget:target action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
}

@end
