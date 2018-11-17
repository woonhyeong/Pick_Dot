//
//  ScrollView.h
//  PickDot
//
//  Created by 이운형 on 17/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic) NSMutableArray *pixelArray;
@property (weak, nonatomic) UIColor *selectedColor;
@property (nonatomic) NSInteger matrixSize;

@end

