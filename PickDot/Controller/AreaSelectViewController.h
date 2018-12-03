//
//  AreaSelectViewController.h
//  PickDot
//
//  Created by 이운형 on 27/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol areaSelectDelegate <NSObject>
@required
- (void)dismiss:(NSInteger)matrixSize;
@end

@interface AreaSelectViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<areaSelectDelegate> delegate;
@property (nonatomic) NSInteger matrixSize;

- (IBAction)createButtonTouched:(UIButton *)sender;
@end

