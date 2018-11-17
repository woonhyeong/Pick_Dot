//
//  ScrollView.m
//  PickDot
//
//  Created by 이운형 on 17/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

-(NSMutableArray*)pixelArray {
    if(_pixelArray == nil){
        _pixelArray = [[NSMutableArray alloc]init];
    }
    return _pixelArray;
}

-(UIColor*)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor clearColor];
    }
    return _selectedColor;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
}

@end
