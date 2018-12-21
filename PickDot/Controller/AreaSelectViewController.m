//
//  AreaSelectViewController.m
//  PickDot
//
//  Created by 이운형 on 27/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "AreaSelectViewController.h"

@interface AreaSelectViewController ()
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *createView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sizeSelectButton;
@property (weak, nonatomic) IBOutlet UIView *sizeSelectView;
@property (weak, nonatomic) IBOutlet UIView *sizeSelectBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *crateButton;
@end

@implementation AreaSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    self.matrixSize = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.blackView addGestureRecognizer:tap];
}

- (void)makeUI {
    [self.view.layer setCornerRadius:5];
    [self.createView.layer setBorderColor:[UIColor colorWithRed:64.0f/255.0f green:177.0f/255.0f blue:129.0f/255.0f alpha:1.0f].CGColor];
    [self.createView.layer setBorderWidth:4.0f];
    [self.sizeSelectView.layer setBorderWidth:4.0f];
    [self.sizeSelectView.layer setBorderColor:[UIColor colorWithRed:64.0/255.0f green:177.0/255.0f blue:129.0/255.0f alpha:1.0f].CGColor];
    
    for (UIButton* b in self.sizeSelectView.subviews) {
        [b.layer setBorderWidth:0.5f];
        [b.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
}
#pragma mark - Tap Gesture
- (void)dismissView {
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
#pragma mark - IBAction methods
- (IBAction)createButtonTouched:(UIButton *)sender {
    [self.delegate dismiss:self.matrixSize];
}

- (IBAction)sizeSelectButtonTouched:(UIButton *)sender {
    [self.sizeSelectBackGroundView setHidden:NO];
}

- (IBAction)selectPixelSize:(UIButton *)sender {
    [self.sizeSelectButton setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    self.matrixSize = sender.tag;
    [self.sizeSelectBackGroundView setHidden:YES];
}
@end
