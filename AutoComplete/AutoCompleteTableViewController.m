//
//  AutoCompleteTableViewController.m
//  AutoComplete
//
//  Created by Oleksii Tiurenkov on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import "AutoCompleteTableViewController.h"
#import "AutoCompleteService.h"
#import "AutoCompleteItemModel.h"
#import "AutoCompletePopoverControllerViewController.h"

@interface AutoCompleteTableViewController ()
{
    NSMutableArray* searchResults;
    dispatch_queue_t queue;
    AutoCompleteService* autocompleteSevice;
}

@end

@implementation AutoCompleteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchResults = [[NSMutableArray alloc] init];
    queue = dispatch_queue_create("com.myapp.myqueue", DISPATCH_QUEUE_CONCURRENT);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] init];

    }
    AutoCompleteItemModel* model = [searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString* searchString = searchText;
    if ([searchString length] > 3)
    {
        autocompleteSevice = [AutoCompleteService autocompleteWithTerm:searchString withDelegate:self];
        [autocompleteSevice search];
    }
}

- (void)autocompleteForTerm:(NSString *)searchTerm WithData:(NSArray *)data
{
    [searchResults removeAllObjects];
    NSMutableArray* result = [[NSMutableArray  alloc] initWithCapacity:10];
    for (int i = 0; (i < 10) && (i < [data count]); i++)
    {

        [result addObject:data[i]];
    }
    [searchResults addObjectsFromArray:result];
    [self.tableView reloadData];
    
    AutoCompletePopoverControllerViewController *popoverController = [[AutoCompletePopoverControllerViewController alloc] initWithNibName:@"AutoCompletePopoverControllerViewController" bundle:nil];
    [popoverController.view setFrame:CGRectMake(50, 50, 200, 300)];
    [popoverController setDataForPopoverTableView:searchResults];
    [self.view.superview addSubview:popoverController.view];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
}
@end
