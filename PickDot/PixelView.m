//
//  PixelView.m
//  PickDot
//
//  Created by 이운형 on 10/11/2018.
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
@end
