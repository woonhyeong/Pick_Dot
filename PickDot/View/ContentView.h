//
//  ContentView.h
//  PickDot
//
//  Created by 이운형 on 23/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PixelView.h"

@interface ContentView : UIView

@property (nonatomic, strong) NSMutableArray *pixelArray;
@property (weak, nonatomic) UIColor *selectedColor;
@property (nonatomic) NSInteger matrixSize;
@property (nonatomic) NSInteger prevSelectedPixelIndex;

-(void)selectPixelAtIndex:(NSInteger)index;
-(void)drawColorToPixel;
-(void)moveSelectedPixelAtIndex:(NSInteger)direction;

@end
