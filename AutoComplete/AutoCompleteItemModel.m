//
//  AutoCompleteItemModel.m
//  AutoComplete
//
//  Created by Maksym Lisevych on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import "AutoCompleteItemModel.h"

@implementation AutoCompleteItemModel

- (instancetype)initItemFromArrayObj:(id)item
{
    self = [super init];

    if (self)
    {
        [self parseReceivedItem:(NSDictionary *)item];
    }

    return self;
}

- (void)parseReceivedItem:(NSDictionary *)receivedItemDictionary
{
    if (receivedItemDictionary)
    {
        self.cacheId = [receivedItemDictionary objectForKey:@"cacheId"];
        self.displayLink = [receivedItemDictionary objectForKey:@"displayLink"];
        self.formattedUrl = [receivedItemDictionary objectForKey:@"formattedUrl"];
        self.htmlFormattedUrl = [receivedItemDictionary objectForKey:@"htmlFormattedUrl"];
        self.htmlSnippet = [receivedItemDictionary objectForKey:@"htmlSnippet"];
        self.htmlTitle = [receivedItemDictionary objectForKey:@"htmlTitle"];
        self.kind = [receivedItemDictionary objectForKey:@"kind"];
        self.link = [receivedItemDictionary objectForKey:@"link"];
        self.pagemap = [receivedItemDictionary objectForKey:@"pagemap"];
        self.snippet = [receivedItemDictionary objectForKey:@"snippet"];
        self.title = [receivedItemDictionary objectForKey:@"title"];
    }
}

@end
