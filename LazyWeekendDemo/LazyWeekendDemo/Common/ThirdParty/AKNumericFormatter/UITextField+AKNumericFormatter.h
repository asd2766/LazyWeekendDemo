//
// This file is subject to the terms and conditions defined in
// file 'LICENSE', which is part of this source code package.
//

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif
#import <UIKit/UIKit.h>
@class AKNumericFormatter;

@interface UITextField(AKNumericFormatter)

@property(nonatomic, strong) AKNumericFormatter* numericFormatter;

-(void)formatCurrentText;

// Method for iOS < 6 compatibility.
// Call it from your UITextFieldDelegate's textField:shouldChangeCharactersInRange:replacementString: method
// when replacementString's length is zero.
-(void)alertDeleteBackwards;

@end