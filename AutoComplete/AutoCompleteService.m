//
//  AutoCompleteService.m
//  AutoComplete
//
//  Created by Oleksii Tiurenkov on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import "AutoCompleteService.h"
#import "AutoCompleteItemModel.h"

@interface AutoCompleteService ()
{
    NSString* searchTerm;
    id<AutocompletionDelegate> delegate;
    NSMutableData* mutableData;
}

@end

@implementation AutoCompleteService



- (instancetype)initWithSearchTerm:(NSString *)aSearchTerm withDelegate:(id<AutocompletionDelegate>)aDelegate
{
    self = [super init];
    if (self)
    {
        searchTerm = aSearchTerm;
        delegate   = aDelegate;
    }
    return self;
}

- (NSURL*) googleURLForTerm:(NSString*)aSearchTerm
{
    NSString* string = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?q=%@&key=AIzaSyBThVMwGPGomoRCfOtAZ3rUZDWc4aQWv5Q&cx=012810251358574654648:om4qr5mdfhs",aSearchTerm];
    NSURL* url = [NSURL URLWithString:string];
    return url;
}

- (void) search
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[self googleURLForTerm:searchTerm]];
    NSURLConnection* connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    mutableData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:mutableData options:kNilOptions error:&error];
    NSArray* items = [dictionary objectForKey:@"items"];
    NSMutableArray* result = [[NSMutableArray  alloc] initWithCapacity:10];
    for (int i = 0; (i < 10) && (i < [items count]); i++)
    {
        AutoCompleteItemModel *receivedItem = [[AutoCompleteItemModel alloc] initItemFromArrayObj:[items objectAtIndex:i]];
        
        [result addObject:receivedItem];
    }
    [delegate autocompleteForTerm:searchTerm WithData:result];
}


+ (instancetype)autocompleteWithTerm:(NSString *)searchTerm withDelegate:(id<AutocompletionDelegate>)delegete
{
    AutoCompleteService*  result = [[AutoCompleteService alloc] initWithSearchTerm:searchTerm withDelegate:delegete];
    return result;
}
@end
