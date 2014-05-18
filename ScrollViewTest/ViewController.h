//
//  ViewController.h
//  ScrollViewTest
//
//  Created by Scott Richards on 5/11/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView+Utilities.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
- (void)keyboardWasShown:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

@end
