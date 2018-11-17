//
//  ViewController.h
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"

typedef enum _drawingState{
    Pen, Eraser
}State;

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, PixelViewDelegate>

@property (weak, nonatomic) IBOutlet ScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPen;
@property (weak, nonatomic) IBOutlet UIButton *buttonEraser;
@property State drawingState;

@end


