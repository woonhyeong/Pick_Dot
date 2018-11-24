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
- (id)initWithIndex:(NSInteger)index Color:(UIColor*)color
{
    self = [super init];
    if (self)
    {
        self.index = index;
        self.color = color;
    }
    return self;
}

-(void)drawSelfView {
    // Make Touched Button
    UIButton* button = [[UIButton alloc]initWithFrame:self.bounds];
    [button addTarget:self.vcDelegate action:@selector(pixelTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

//- (void)buttonTouched {
//    [self.delegate pixelTouched:self];
//}

@end

