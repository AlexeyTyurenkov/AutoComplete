//
//  AutoCompletePopoverControllerViewController.h
//  AutoComplete
//
//  Created by Maksym Lisevych on 7/2/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoCompleteService.h"

@interface AutoCompletePopoverControllerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AutocompletionDelegate>
@property (strong, nonatomic) IBOutlet UITableView *popoverTableView;

- (void)setDataForPopoverTableView:(NSArray*)dataArray;

@end
