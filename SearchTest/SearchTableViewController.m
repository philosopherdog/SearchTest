//
//  SearchTableViewController.m
//  SearchTest
//
//  Created by steve on 2015-10-30.
//  Copyright © 2015 steve. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>
@property (nonatomic) NSArray *data;
@property (nonatomic) UISearchController *searchController;
@property (nonatomic) NSArray *filteredData;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [UIFont familyNames];// creates an array of font names for testing
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.filteredData.count;
    }
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.searchController.active) {
        cell.textLabel.text = self.filteredData[indexPath.row];
        return cell;
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSLog(@"%@", searchText);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", self.filteredData);
    [self.tableView reloadData];
}


@end
