//
//  PixelView.h
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PixelView;

@protocol PixelViewDelegate
-(void) pixelTouched : (PixelView *)requestor;
@end

@interface PixelView : UIView

@property UIColor* color;
@property NSInteger index;

@property (assign) id<PixelViewDelegate> delegate;

<<<<<<< HEAD:PickDot/View/PixelView.h
- (id)initWithRow:(NSInteger)row AtIndex:(NSInteger)index Color:(UIColor*)color;
=======
- (id)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(UIColor*)color;
- (void)setBackgroundColor:(UIColor *)backgroundColor;
>>>>>>> parent of d1a95c2... [added tap action pixelView]:PickDot/PixelView.h

@end

