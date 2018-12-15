//
//  OpenTableViewController.m
//  PickDot
//
//  Created by 이운형 on 04/12/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "OpenTableViewController.h"

@interface OpenTableViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@end

@implementation OpenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeList];
    [self.view.layer setCornerRadius:5];
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
    NSString* jsonString = [userDefaults objectForKey:@"files"];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.list = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}

#pragma mark - IBAction methods
- (IBAction)editButtonTouched:(UIButton *)sender {
    if ([self.tableView isEditing]) {
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.editButton setTitle:@"Cancle" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString* jsonString = [userDefaults objectForKey:@"files"];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray* array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
        [array removeObjectAtIndex:[array indexOfObject:self.list[indexPath.row]]];
        jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [userDefaults setObject:jsonString forKey:@"files"];
        [userDefaults removeObjectForKey:self.list[indexPath.row]];
        
        NSInteger i = [userDefaults integerForKey:@"count"];
        [userDefaults setInteger:(i-1) forKey:@"count"];
        
        [self.list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
@end
