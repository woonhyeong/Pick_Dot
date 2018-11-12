//
//  ViewController.m
//  PickDot
//
//  Created by 이운형 on 10/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ViewController.h"

typedef enum _drawingState{
    Pen, Eraser
}State;

#define PIXEL_MATRIX_SIZE 20
@interface ViewController ()
@property (nonatomic) UIColor *selectedColor;
@property (weak, nonatomic) IBOutlet UILabel *selectedColorLabel;
@property State drawingState;
@end

@implementation ViewController

int prevSelectedIndexAtPixel = -1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makePixelInScrollView];
    [self addTapGesture];
}

#pragma mark - Getter & Setter
-(UIColor*)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor whiteColor];
    }
    return _selectedColor;
}

-(NSMutableArray*)pixelArray {
    if (_pixelArray == nil) {
        _pixelArray = [[NSMutableArray alloc]init];
    }
    return _pixelArray;
}

#pragma mark - Tap Gesture
-(void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pixelColorChange:)];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    [tapGesture setEnabled:TRUE];
    [self.scrollView addGestureRecognizer:tapGesture];
}

-(void)pixelColorChange:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.scrollView];
    int row = location.x/(PIXEL_MATRIX_SIZE-1);
    int column = location.y/(PIXEL_MATRIX_SIZE-1);
    int index = row + column*PIXEL_MATRIX_SIZE;
    PixelView* selectedPixel = ((PixelView*)self.pixelArray[index]);
    if(selectedPixel.color != self.selectedColor){
        [selectedPixel setBackgroundColor:self.selectedColor];
    }
    
    [self selectPixelAtIndex:index];
}


#pragma mark - Private Methods
-(void)makePixelInScrollView {
    [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x
                                         , self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.width)];
    [self.scrollView.layer setBorderWidth:1.0];
    [self.scrollView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    
    int width = self.scrollView.frame.size.width/PIXEL_MATRIX_SIZE;
    int height = self.scrollView.frame.size.height/PIXEL_MATRIX_SIZE;
    
    for (int i = 0; i < PIXEL_MATRIX_SIZE; i++) {
        for (int k = 0; k < PIXEL_MATRIX_SIZE; k++) {
            PixelView *pixel = [[PixelView alloc]initWithRow:k Column:i Color:UIColor.whiteColor];
            pixel.layer.borderWidth = 0.5f;
            pixel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
            [pixel setFrame:CGRectMake(k*width, i*height, width, height)];
            [self.pixelArray addObject:pixel];
            [self.scrollView addSubview:pixel];
        }
    }
}

-(void)setPenBorder:(BOOL)isEnable {
    if (isEnable) {
        [self.buttonPen setBackgroundColor:[UIColor colorWithRed:90.0/255.0 green:171.0/255.0 blue:255.0/255.0 alpha:0.5]];
        [self.buttonEraser setBackgroundColor:[UIColor clearColor]];
    }else {
        [self.buttonPen setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)setEraserBorder:(BOOL)isEnable {
    if (isEnable) {
        [self.buttonEraser setBackgroundColor:[UIColor colorWithRed:90.0/255.0 green:171.0/255.0 blue:255.0/255.0 alpha:0.5]];
        [self.buttonPen setBackgroundColor:[UIColor clearColor]];
    }else {
        [self.buttonEraser setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)selectPixelAtIndex:(NSInteger)index {
    if(prevSelectedIndexAtPixel > 0){
        PixelView* pixel = ((PixelView*)self.pixelArray[prevSelectedIndexAtPixel]);
        pixel.layer.borderWidth = 0.5f;
        pixel.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    }
    PixelView* pixel = ((PixelView*)self.pixelArray[index]);
    pixel.layer.borderWidth = 2.0f;
    pixel.layer.borderColor = [[UIColor redColor]CGColor];
    prevSelectedIndexAtPixel = (int)index;
}

#pragma mark - IBAction methods
- (IBAction)keyboardAction:(UIButton *)sender {
    NSString* title = sender.titleLabel.text;
    
    if ([title isEqualToString:@"L"]) {
        if(prevSelectedIndexAtPixel%PIXEL_MATRIX_SIZE>0){
            [self selectPixelAtIndex:(prevSelectedIndexAtPixel-1)];
        }
    } else if ([title isEqualToString:@"R"]){
        if (prevSelectedIndexAtPixel%PIXEL_MATRIX_SIZE < 19) {
            [self selectPixelAtIndex:(prevSelectedIndexAtPixel+1)];
        }
    } else if ([title isEqualToString:@"U"]){
        if (prevSelectedIndexAtPixel > 19) {
            [self selectPixelAtIndex:(prevSelectedIndexAtPixel-PIXEL_MATRIX_SIZE)];
        }
    } else if ([title isEqualToString:@"D"]){
        if (prevSelectedIndexAtPixel < PIXEL_MATRIX_SIZE*PIXEL_MATRIX_SIZE - PIXEL_MATRIX_SIZE) {
            [self selectPixelAtIndex:(prevSelectedIndexAtPixel+PIXEL_MATRIX_SIZE)];
        }
    } else if ([title isEqualToString:@"Draw"]){
        PixelView* selectedPixel = ((PixelView*)self.pixelArray[prevSelectedIndexAtPixel]);
        if(selectedPixel.color != self.selectedColor){
            [selectedPixel setBackgroundColor:self.selectedColor];
        }
        
        [self selectPixelAtIndex:prevSelectedIndexAtPixel];
    }
}

- (IBAction)changeDrawingState:(UIButton *)sender {
    NSString* title = sender.titleLabel.text;
    if ([title isEqualToString:@"Pen"]) {
        self.drawingState = Pen;
        [self setPenBorder:TRUE];
        self.selectedColor  = self.selectedColorLabel.backgroundColor;
    }else if ([title isEqualToString:@"Eraser"]){
        self.drawingState = Eraser;
        [self setEraserBorder:TRUE];
        self.selectedColor = [UIColor clearColor];
    }
}

- (IBAction)changeSelectedColor:(UIButton *)sender {
    if(self.drawingState == Pen){
        self.selectedColor = sender.backgroundColor;
        [self.selectedColorLabel setBackgroundColor:sender.backgroundColor];
    }
}
@end
