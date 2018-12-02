//
//  SaveSelectViewController.h
//  PickDot
//
//  Created by 이운형 on 02/12/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol saveSelectDelegate <NSObject>
@required
- (void)saveFile:(NSString*)fileTitle;
@end

@interface SaveSelectViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<saveSelectDelegate> delegate;

@end

