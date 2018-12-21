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
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@end

@implementation SaveSelectViewController
bool keyboardIsShowing;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    
    keyboardIsShowing = NO;
    [self.saveButton setEnabled:NO];
    [self.inputField addTarget:self action:@selector(updateLabelUsingContentsOfTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.inputField setKeyboardType:UIKeyboardTypeDefault];
    self.inputField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UITapGestureRecognizer *tapBlackView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissViewAndKeyboard)];
    tapBlackView.delegate = self;
    tapBlackView.numberOfTapsRequired = 1;
    [self.blackView addGestureRecognizer:tapBlackView];
    UITapGestureRecognizer *tapSaveView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapSaveView.delegate = self;
    tapSaveView.numberOfTapsRequired = 1;
    [self.saveView addGestureRecognizer:tapSaveView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)makeUI {
    [self.view.layer setCornerRadius:5];
    [self.saveView.layer setBorderColor:[UIColor colorWithRed:64.0f/255.0f green:177.0f/255.0f blue:129.0f/255.0f alpha:1.0f].CGColor];
    [self.saveView.layer setBorderWidth:4.0f];
}

#pragma mark - Notifications
- (void)keyboardDidShow: (NSNotification *) notif{
    keyboardIsShowing = YES;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    keyboardIsShowing = NO;
}

#pragma mark - Tap Gesture
- (void)dismissViewAndKeyboard {
    if (keyboardIsShowing) {
        [self.inputField resignFirstResponder];
    } else {
       // [self dismissViewControllerAnimated:YES completion:nil];
        [UIView animateWithDuration:.25 animations:^{
            self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
            self.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}
- (void)dismissKeyboard {
    if (keyboardIsShowing) {
        [self.inputField resignFirstResponder];
    }
}

#pragma mark - UITextField method
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:self.inputField.text] == nil) {
         [self.delegate saveFile:self.inputField.text];
    } else {
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
