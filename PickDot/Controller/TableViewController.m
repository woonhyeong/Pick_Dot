//
//  TableViewController.m
//  PickDot
//
//  Created by 이운형 on 25/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer setCornerRadius:5];
    [self.view.layer setBorderWidth:1.0f];
    [self.view.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view setHidden:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSArray*)menu {
    if (_menu == nil) {
        _menu = [[NSArray alloc]initWithObjects:@"New",@"Save",@"Load",@"Export", nil];
    }
    return _menu;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"Menu Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    NSString* cellTitle = self.menu[indexPath.row];
    cell.textLabel.text = cellTitle;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     0: New  1: Save  2: Open 3: Export
     */
    switch (indexPath.row) {
        case 0:
            [self.delegate selectNewCell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case 1:
            [self.delegate selectSaveCell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case 2:
            [self.delegate selectLoadCell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case 3:
            [self.delegate selectExportCell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        default:
            break;
    }
}

@end
