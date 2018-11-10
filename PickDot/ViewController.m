//
//  ViewController.m
//  PickDot
//
//  Created by 이운형 on 10/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ViewController.h"

#define PIXEL_MATRIX_SIZE 20
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makePixelInScrollView];
}

- (NSMutableArray*)pixelArray {
    if (_pixelArray == nil) {
        _pixelArray = [[NSMutableArray alloc]init];
    }
    return _pixelArray;
}

-(void)makePixelInScrollView {
    int width = self.scrollView.frame.size.width/PIXEL_MATRIX_SIZE;
    int height = self.scrollView.frame.size.height/PIXEL_MATRIX_SIZE;
    
    for (int i = 0; i < PIXEL_MATRIX_SIZE; i++) {
        for (int k = 0; k < PIXEL_MATRIX_SIZE; k++) {
            PixelView *pixel = [[PixelView alloc]initWithRow:k Column:i Color:UIColor.whiteColor];
            pixel.layer.borderWidth = 1.0f;
            pixel.layer.borderColor = [[UIColor darkGrayColor]CGColor];
            [pixel setFrame:CGRectMake(i*width, k*height, width, height)];
            [self.pixelArray addObject:pixel];
            [self.scrollView addSubview:pixel];
        }
    }
}

@end
