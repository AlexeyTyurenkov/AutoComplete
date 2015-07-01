//
//  AutoCompleteTableViewController.m
//  AutoComplete
//
//  Created by Oleksii Tiurenkov on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import "AutoCompleteTableViewController.h"

@interface AutoCompleteTableViewController ()
{
    NSMutableArray* searchResults;
    dispatch_queue_t queue;
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
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d, data: %@", indexPath.row, [searchResults objectAtIndex:indexPath.row]];
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString* searchString = searchText;
    __weak UITableView* weakTableView = self.tableView;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //[NSThread sleepForTimeInterval:arc4random()/UINT32_MAX + 2.0];
        NSError* error = nil;
        NSURL* url = [NSURL URLWithString:@"https://www.googleapis.com/customsearch/v1?q=ree&key=AIzaSyBThVMwGPGomoRCfOtAZ3rUZDWc4aQWv5Q&cx=012810251358574654648:om4qr5mdfhs"];
        NSData* resultData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        [searchResults removeAllObjects];
        if ([searchString length] && !error)
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:&error];
            NSArray* items = [dictionary objectForKey:@"items"];
            NSMutableArray* result = [[NSMutableArray  alloc] initWithCapacity:10];
            for (int i = 0; i < 10; i++)
            {
                AutoCompleteItemModel *receivedItem = [[AutoCompleteItemModel alloc] initItemFromArrayObj:[items objectAtIndex:i]];
                
                [result addObject:receivedItem];
            }
            [searchResults addObjectsFromArray:result];
            NSLog(@"%@",items);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakTableView reloadData];
        });

    });

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
}
@end
