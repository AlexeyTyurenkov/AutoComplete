//
//  AutoCompletePopoverControllerViewController.m
//  AutoComplete
//
//  Created by Maksym Lisevych on 7/2/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import "AutoCompletePopoverControllerViewController.h"
#import "AutoCompleteTableViewController.h"
#import "AutoCompleteItemModel.h"

@interface AutoCompletePopoverControllerViewController ()
{
    NSMutableArray* searchResults;
    AutoCompleteService* autocompleteSevice;
}
@end

@implementation AutoCompletePopoverControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchResults = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] init];
        
    }
    AutoCompleteItemModel* model = [searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
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
    [self.popoverTableView reloadData];
    
}

- (void)setDataForPopoverTableView:(NSArray *)dataArray
{
    [searchResults addObjectsFromArray:dataArray];
    [self.popoverTableView reloadData];
}

@end
