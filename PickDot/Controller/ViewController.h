//
//  ViewController.h
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
#import "ContentView.h"
#import "PixelView.h"

typedef enum _drawingState{
    Left, Right, Up, Down
} Direction;

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPen;
@property (weak, nonatomic) IBOutlet UIButton *buttonEraser;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor;

- (IBAction)pixelTouch:(UIButton *)sender;
- (IBAction)menuButtonTouched:(UIButton *)sender;
- (IBAction)colorButtonTouched:(UIButton *)sender;
- (IBAction)penButtonTouched:(UIButton *)sender;
- (IBAction)eraserButtonTouched:(UIButton *)sender;
- (IBAction)arrowButtonTouched:(UIButton *)sender;
@end


