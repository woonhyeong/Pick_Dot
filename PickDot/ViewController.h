//
//  ViewController.h
//  PickDot
//
//  Created by 이운형 on 10/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PixelView.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) NSMutableArray* pixelArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPen;
@property (weak, nonatomic) IBOutlet UIButton *buttonEraser;

- (IBAction)keyboardAction:(UIButton *)sender;
- (IBAction)changeDrawingState:(UIButton *)sender;
- (IBAction)changeSelectedColor:(UIButton *)sender;
@end

