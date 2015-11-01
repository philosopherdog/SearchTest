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
    self.data = [UIFont familyNames];// creates an array of data of font names for testing
    [self setupSearchController];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    
    // adds search bar to tableView header area
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - TableView DataSource

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
        // setup cell when searching
        NSString *fontName = self.filteredData[indexPath.row];
        cell.textLabel.text = fontName;
        cell.textLabel.font = [UIFont fontWithName:fontName size:24];
        return cell;
    }
    // setup cell when not searching
    NSString *fontName = self.data[indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:24];
    return cell;
}

#pragma mark - UISearchResultUpdating Protocol method

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}


@end
