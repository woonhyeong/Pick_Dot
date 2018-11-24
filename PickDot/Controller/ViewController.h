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
    Pen, Eraser
}State;

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) IBOutlet ContentView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPen;
@property (weak, nonatomic) IBOutlet UIButton *buttonEraser;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor;
@property State drawingState;

- (IBAction)menuButtonTouched:(UIButton *)sender;
- (IBAction)colorButtonTouched:(UIButton *)sender;
- (IBAction)buttontouch:(UIButton *)sender;

@end


