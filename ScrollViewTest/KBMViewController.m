//
//  KBMViewController.m
//  ScrollViewTest
//
//  Created by Scott Richards on 5/18/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "KBMViewController.h"

@interface KBMViewController ()
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (assign, nonatomic) CGSize keyboardSize;
@property (strong, nonatomic) UITextField *activeField;
@end

@implementation KBMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    self.myScrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
    [self.myScrollView setScrollEnabled:YES];
    [self.myScrollView setContentSize:CGSizeMake(320,800)];
    UIView *contentView;
    if (self.view.subviews && [self.view.subviews[0] isKindOfClass:[UIView class]])
    {
        contentView = self.view.subviews[0];
        [contentView removeFromSuperview];
        [self.view addSubview:self.myScrollView];
        [self.myScrollView addSubview:contentView];

    }
    [self registerForKeyboardNotifications];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Keyboard Management

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
    
    [self scrollFieldIntoView:self.activeField rootView:self.view keyboardSize:self.keyboardSize scrollView:self.myScrollView];
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
