//
//  AutoCompleteTableViewController.h
//  AutoComplete
//
//  Created by Oleksii Tiurenkov on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoCompleteService.h"
@interface AutoCompleteTableViewController : UITableViewController <UISearchBarDelegate, AutocompletionDelegate>
@end
