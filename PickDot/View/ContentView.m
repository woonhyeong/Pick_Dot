//
//  ContentView.m
//  PickDot
//
//  Created by 이운형 on 23/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ContentView.h"

#define DEFAULT_MATRIX_SIZE 16
@interface ContentView()

@end

@implementation ContentView

#pragma mark - Initialization
-(id)init{
    self = [super init];
    if(self){
        self.matrixSize = DEFAULT_MATRIX_SIZE;
        [self setFrame:CGRectMake(0, 0, 20*DEFAULT_MATRIX_SIZE, 20*DEFAULT_MATRIX_SIZE)];
        self.prevSelectedPixelIndex = -1;
    }
    return self;
}

#pragma mark - Getter & Setter
-(NSMutableArray*)pixelArray {
    if(_pixelArray == nil){
        _pixelArray = [[NSMutableArray alloc]init];
    }
    return _pixelArray;
}

- (void)setMatrixSize:(NSInteger)matrixSize {
    _matrixSize = matrixSize;
    [self removeAllSubView];
    [self setFrame:CGRectMake(0, 0, 20*_matrixSize, 20*_matrixSize)];
    self.prevSelectedPixelIndex = -1;
    [self.pixelArray removeAllObjects];
    [self makePixel];
}

-(UIColor*)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor whiteColor];
    }
    return _selectedColor;
}

#pragma mark - Private Methods
-(void)makePixel {
    for (int i = 0; i < self.matrixSize; i++) {
        for(int k = 0; k <self.matrixSize; k++) {
            PixelView* pixel = [[PixelView alloc]initWithIndex:i*self.matrixSize+k Color:self.selectedColor];
            [pixel setFrame:CGRectMake(k*20,i*20, 20, 20)];
            [pixel drawSelfView];
            [self.pixelArray addObject:pixel];
            [self addSubview:pixel];
        }
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
}

#pragma mark - Public Methods
-(void)selectPixelAtIndex:(NSInteger)index {
    if(self.prevSelectedPixelIndex >= 0){
        PixelView* pixel = ((PixelView*)self.pixelArray[self.prevSelectedPixelIndex]);
        pixel.layer.borderWidth = 0.5f;
        pixel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    }
    PixelView* pixel = ((PixelView*)self.pixelArray[index]);
    pixel.layer.borderWidth = 2.0f;
    pixel.layer.borderColor = [[UIColor redColor]CGColor];
    self.prevSelectedPixelIndex = index;
}

-(void)drawColorToPixel {
    if (self.prevSelectedPixelIndex >= 0) {
        [((PixelView*)self.pixelArray[self.prevSelectedPixelIndex]) setBackgroundColor:self.selectedColor];
    }
}

-(void)moveSelectedPixelAtIndex:(NSInteger)direction {
    /*
     0: left  1: right  2: up  3: down
     */
    if(self.prevSelectedPixelIndex >= 0){
        switch (direction) {
            case 0:
                if (self.prevSelectedPixelIndex%self.matrixSize > 0 ) {
                    [self selectPixelAtIndex:self.prevSelectedPixelIndex-1];
                }
                break;
            case 1:
                if (self.prevSelectedPixelIndex%self.matrixSize < self.matrixSize-1 ) {
                    [self selectPixelAtIndex:self.prevSelectedPixelIndex+1];
                }
                break;
            case 2:
                if (self.prevSelectedPixelIndex > self.matrixSize-1 ) {
                    [self selectPixelAtIndex:self.prevSelectedPixelIndex - self.matrixSize];
                }
                break;
            case 3:
                if (self.prevSelectedPixelIndex < self.matrixSize*self.matrixSize - self.matrixSize ) {
                    [self selectPixelAtIndex:self.prevSelectedPixelIndex + self.matrixSize];
                }
                break;
            default:
                break;
        }
    }
}

- (void)removeAllSubView {
    for (PixelView* pixel in self.subviews) {
        [pixel removeFromSuperview];
    }
}

- (NSDictionary *)pixelArrayConvertedToDictionary {
    NSMutableDictionary* mdic = [[NSMutableDictionary alloc]init];
    [mdic setValue:[NSNumber numberWithInteger:self.pixelArray.count] forKey:@"Size"];
    
    for (PixelView* pixel in self.pixelArray) {
        CGFloat r, g, b, a, h, s, w;
        NSString* colorToString;
        
        if ([pixel.backgroundColor getRed:&r green:&g blue:&b alpha:&a])
            colorToString =  [NSString stringWithFormat:@"rgba:%f,%f,%f,%f", r,g,b,a];
        else if ([pixel.backgroundColor getHue:&h saturation:&s brightness:&b alpha:&a])
            colorToString = [NSString stringWithFormat:@"hsba:%f,%f,%f,%f", h,s,b,a];
        else if ([pixel.backgroundColor getWhite:&w alpha:&a])
            colorToString = [NSString stringWithFormat:@"wa:%f,%f", w, a];

        [mdic setObject:colorToString forKey:[NSString stringWithFormat:@"%ld",pixel.index]];
    }
    
    return [mdic copy];
}
@end
