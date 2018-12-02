//
//  SaveSelectViewController.m
//  PickDot
//
//  Created by 이운형 on 02/12/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "SaveSelectViewController.h"

@interface SaveSelectViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation SaveSelectViewController
bool keyboardIsShowing;

- (void)viewDidLoad {
    [super viewDidLoad];
    keyboardIsShowing = NO;
    [self.saveButton setEnabled:NO];
    [self.inputField addTarget:self action:@selector(updateLabelUsingContentsOfTextField:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

#pragma mark - Notifications
- (void)keyboardDidShow: (NSNotification *) notif{
    keyboardIsShowing = YES;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    keyboardIsShowing = NO;
}

#pragma mark - Tap Gesture
-(void) dismissKeyboard {
    if (keyboardIsShowing) {
        [self.inputField resignFirstResponder];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)updateLabelUsingContentsOfTextField:(id)sender {
    if (self.inputField.text.length < 1) {
        [self.saveButton setEnabled:NO];
    } else {
        [self.saveButton setEnabled:YES];
    }
}

#pragma mark - IBAction methods
- (IBAction)saveButtonTouched:(UIButton *)sender {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Your input title is overlapped."
                                 message:@"Please rewrite title."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   self.inputField.text = nil;
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    if ([userDefaults objectForKey:self.inputField.text] == nil) {
    //        return;
    //    } else {
    //        [self.delegate saveFile:self.inputField.text];
    //    }
}
@end
