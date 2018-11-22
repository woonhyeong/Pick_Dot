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

<<<<<<< HEAD
@property (nonatomic, weak) ViewController * vcDelegate;
=======
<<<<<<< HEAD:PickDot/View/PixelView.h
<<<<<<< HEAD:PickDot/View/PixelView.h
>>>>>>> 7793580201e35a87e0b36f80ae2d802732fd9c12
- (id)initWithRow:(NSInteger)row AtIndex:(NSInteger)index Color:(UIColor*)color;
=======
=======
>>>>>>> parent of d1a95c2... [added tap action pixelView]:PickDot/PixelView.h
- (id)initWithRow:(NSInteger)row Column:(NSInteger)column Color:(UIColor*)color;
- (void)setBackgroundColor:(UIColor *)backgroundColor;
>>>>>>> parent of d1a95c2... [added tap action pixelView]:PickDot/PixelView.h

@end

