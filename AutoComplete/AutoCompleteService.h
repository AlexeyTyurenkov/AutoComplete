//
//  AutoCompleteService.h
//  AutoComplete
//
//  Created by Oleksii Tiurenkov on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AutocompletionDelegate <NSObject>

- (void) autocompleteForTerm:(NSString*)searchTerm WithData:(NSArray*)data;

@end

@interface AutoCompleteService : NSObject <NSURLConnectionDataDelegate>

- (instancetype)initWithSearchTerm:(NSString*)searchTerm withDelegate:(id<AutocompletionDelegate>)delegete;

+ (instancetype)autocompleteWithTerm:(NSString*)searchTerm withDelegate:(id<AutocompletionDelegate>)delegete;

@end
