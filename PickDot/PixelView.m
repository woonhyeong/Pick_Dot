//
//  PixelView.m
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "PixelView.h"

@implementation PixelView

#pragma mark - initialization
- (id)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(UIColor*)color
{
    self = [super init];
    if (self)
    {
        _row = row;
        _column = column;
        _color = color;
    }
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    [self.layer setBackgroundColor:backgroundColor.CGColor];
    [self setColor:backgroundColor];
}

- (void)drawRect:(CGRect)rect

{
    [super drawRect:rect];
    
    // Make Touched Button
    UIButton * button = [[UIButton alloc]initWithFrame:self.frame];
    
//    [button addTarget:self action:@selector(buttonType) forControlEvents:(UIControlEventTouchUpInside)];
    [button addTarget:self.vcDelegate action:@selector(buttontouch:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = 8;
    
    [self addSubview:button];
    
    [self setBackgroundColor:[UIColor yellowColor]];
}

- (void)buttonTouched {
    NSLog(@"touched");
}



@end

