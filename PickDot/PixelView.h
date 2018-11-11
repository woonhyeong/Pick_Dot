//
//  PixelView.h
//  PickDot
//
//  Created by 이운형 on 10/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PixelView : UIView

@property UIColor* color;
@property NSInteger row;
@property NSInteger column;

- (id)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(UIColor*)color;
- (void)setBackgroundColor:(UIColor *)backgroundColor;
@end

