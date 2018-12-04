//
//  OpenTableViewController.h
//  PickDot
//
//  Created by 이운형 on 04/12/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadPixelDelegate <NSObject>
@required
- (void)loadPixelFromJsonData:(NSString*)jsonKey;
@end

@interface OpenTableViewController : UITableViewController

@property (nonatomic, assign) id<LoadPixelDelegate> delegate;
@end
