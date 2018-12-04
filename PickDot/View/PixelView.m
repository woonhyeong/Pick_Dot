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

- (void)drawSelfView {
    // Make Touched Button
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button addTarget:self.vcDelegate action:@selector(pixelTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:button];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
}

- (void)drawSelfView:(NSString*)rgbString {
    
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button addTarget:self.vcDelegate action:@selector(pixelTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *comps = [rgbString componentsSeparatedByString:@":"];
    NSArray *colors = [comps[1] componentsSeparatedByString:@","];
    NSUInteger count = colors.count;
    CGFloat values[4] = {0,0,0,0};
    for (NSUInteger i = 0; i < count; i++){
        values[i] = [colors[i] floatValue];
    }
    
    if ([comps[0] isEqualToString:@"rgba"])
        [self setBackgroundColor:[UIColor colorWithRed:values[0] green:values[1] blue:values[2] alpha:values[3]]];
    else if ([comps[0] isEqualToString:@"hsba"])
        [self setBackgroundColor:[UIColor colorWithHue:values[0] saturation:values[1] brightness:values[2] alpha:values[3]]];
    else if ([comps[0] isEqualToString:@"wa"])
        [self setBackgroundColor:[UIColor colorWithWhite:values[0] alpha:values[1]]];
    
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

