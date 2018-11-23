//
//  ContentView.m
//  PickDot
//
//  Created by 이운형 on 23/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ContentView.h"

#define DEFAULT_MATRIX_SIZE 20
@implementation ContentView

#pragma mark - Initialization
-(id)init {
    self = [super init];
    if(self){
        [self setFrame:CGRectMake(0, 0, DEFAULT_MATRIX_SIZE*DEFAULT_MATRIX_SIZE, DEFAULT_MATRIX_SIZE*DEFAULT_MATRIX_SIZE)];
    }
    return self;
}

#pragma mark - Getter & Setter
-(NSMutableArray*)pixelArray {
    if(_pixelArray == nil){
        _pixelArray = [[NSMutableArray alloc]init];
        [self makePixel];
    }
    return _pixelArray;
}

-(NSInteger)matrixSize {
    if (_matrixSize < 20) {
        _matrixSize = DEFAULT_MATRIX_SIZE;
    }
    return _matrixSize;
}

-(UIColor*)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor clearColor];
    }
    return _selectedColor;
}

#pragma mark - Private Methods
-(void)makePixel {
    for (int i = 0; i < self.matrixSize; i++) {
        for(int k = 0; k <self.matrixSize; k++) {
            PixelView* pixel = [[PixelView alloc]initWithIndex:i*self.matrixSize+k Color:self.selectedColor];
            [pixel setFrame:CGRectMake(k*self.matrixSize,i*self.matrixSize, 20, 20)];
            [pixel drawSelfView];
            [self.pixelArray addObject:pixel];
        }
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    for (int i = 0; i < [self.pixelArray count]; i++) {
        [self addSubview:self.pixelArray[i]];
    }
}

@end
