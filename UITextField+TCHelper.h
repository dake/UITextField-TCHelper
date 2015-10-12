//
//  UITextField+TCHelper.h
//  Dake
//
//  Created by Dake on 15/9/15.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TCTextFieldHelperDelegate <NSObject>

@optional
- (void)tc_textFieldValueChanged:(UITextField *)sender;

@end

@interface UITextField (TCHelper)

@property (nonatomic, assign) NSInteger tc_maxTextLength;
@property (nonatomic, assign) id<TCTextFieldHelperDelegate> tc_delegate;

@end



