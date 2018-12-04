//
//  TableViewController.h
//  PickDot
//
//  Created by 이운형 on 25/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableDelegate <NSObject>
@required
- (void)selectSaveCell;
- (void)selectNewCell;
- (void)selectLoadCell;
@end

@interface TableViewController : UITableViewController

@property (nonatomic) NSArray* menu;
@property (nonatomic, assign) id<TableDelegate> delegate;

@end

