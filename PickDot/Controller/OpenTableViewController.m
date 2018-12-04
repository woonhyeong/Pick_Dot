//
//  OpenTableViewController.m
//  PickDot
//
//  Created by 이운형 on 04/12/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "OpenTableViewController.h"

@interface OpenTableViewController ()
@property (nonatomic, strong) NSArray *list;
@end

@implementation OpenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeList];
    [self.view.layer setBorderWidth:1.0f];
    [self.view.layer setBorderColor:[UIColor blackColor].CGColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - Private Methods
- (void)makeList {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* array = [userDefaults objectForKey:@"files"];
    self.list = [[NSArray alloc]initWithArray:array];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"count"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"Load Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    NSString* cellTitle = self.list[indexPath.row];
    cell.textLabel.text = cellTitle;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate loadPixelFromJsonData:self.list[indexPath.row]];
}
@end
