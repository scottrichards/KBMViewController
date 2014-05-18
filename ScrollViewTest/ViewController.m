//
//  ViewController.m
//  ScrollViewTest
//
//  Created by Scott Richards on 5/11/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (assign, nonatomic) CGSize keyboardSize;
@property (strong, nonatomic) IBOutlet UITextField *labelField;
@property (strong, nonatomic) UITextField *activeField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    self.myScrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
    [self.myScrollView setScrollEnabled:YES];
    [self.myScrollView setContentSize:CGSizeMake(320,800)];
    [self.contentView removeFromSuperview];
    [self.view addSubview:self.myScrollView];
    [self.myScrollView addSubview:self.contentView];
    CGRect scrollFrame = self.myScrollView.frame;
    NSLog(@"self.myScrollView x: %f, y: %f, w: %f, h: %f",scrollFrame.origin.x,scrollFrame.origin.y,scrollFrame.size.width,scrollFrame.size.height);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSLog(@"screenRect x: %f, y: %f, w: %f, h: %f",screenRect.origin.x,screenRect.origin.y,screenRect.size.width,screenRect.size.height);
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    self.keyboardSize = [self insetScrollViewWhenKeyboardWasShown:aNotification scrollView:self.myScrollView];
    
//    [self scrollFieldIntoView:self.labelField rootView:self.view keyboardSize:self.keyboardSize scrollView:self.myScrollView];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self restoreScrollViewWhenKeyboardWillBeHidden:aNotification scrollView:self.myScrollView];
}
*/

#pragma mark keyboard management

- (void)registerForKeyboardNotifications
{
#ifdef DEBUG
    NSLog(@"registerForKeyboardNotifications %@", self);
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
#ifdef DEBUG
    NSLog(@"unregisterForKeyboardNotifications %@", self);
#endif
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    self.keyboardSize = [self insetScrollViewWhenKeyboardWasShown:aNotification scrollView:self.myScrollView];
    
    [self scrollFieldIntoView:self.labelField rootView:self.view keyboardSize:self.keyboardSize scrollView:self.myScrollView];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}



@end
