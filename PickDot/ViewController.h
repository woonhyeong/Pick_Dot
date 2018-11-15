//
//  ViewController.h
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PixelView.h"
#import "ColorView.h"
#import "PixelBrain.h"

typedef enum _drawingState{
    Pen, Eraser
}State;

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, PixelViewDelegate>

@property (nonatomic) NSMutableArray *pixelArray;
@property (weak, nonatomic) UIColor *selectedColor;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPen;
@property (weak, nonatomic) IBOutlet UIButton *buttonEraser;
@property State drawingState;

@end


