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
@end

@implementation AreaSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.matrixSize = 0;
}

- (void)makeButton {
   
}
- (IBAction)createButtonTouched:(UIButton *)sender {
    [self.delegate dismiss:self.matrixSize];
}

- (IBAction)sizeSelectButtonTouched:(UIButton *)sender {
    [self.sizeSelectBackGroundView setHidden:NO];
}

- (IBAction)selectPixelSize:(UIButton *)sender {
    [self.sizeSelectButton setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [self.sizeSelectBackGroundView setHidden:YES];
}
@end
