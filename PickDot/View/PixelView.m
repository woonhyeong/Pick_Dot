//
//  PixelView.m
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "PixelView.h"
@interface PixelView()
@property (nonatomic) UIButton* button;
@end

@implementation PixelView

#pragma mark - initialization
- (id)initWithRow:(NSInteger)row AtIndex:(NSInteger)index Color:(UIColor*)color
{
    self = [super init];
    if (self)
    {
        self.index = index;
        self.color = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
     // Make Touched Button
    if (self.button == nil) {
        self.button =[[UIButton alloc]initWithFrame:self.frame];
        [self.button addTarget:self action:@selector(buttonTouched) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_button];
        [self setBackgroundColor:[UIColor yellowColor]];
    }
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.layer.backgroundColor = self.color.CGColor;
}

- (void)buttonTouched {
    [self.delegate pixelTouched:self];
}

@end

