//
//  PixelView.h
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PixelView;
@class ViewController;

@protocol PixelViewDelegate
-(void) pixelTouched : (PixelView *)requestor;
@end

@interface PixelView : UIView

@property UIColor* color;
@property NSInteger index;

@property (assign) id<PixelViewDelegate> delegate;

@property (nonatomic, weak) ViewController * vcDelegate;
- (id)initWithRow:(NSInteger)row AtIndex:(NSInteger)index Color:(UIColor*)color;

@end

