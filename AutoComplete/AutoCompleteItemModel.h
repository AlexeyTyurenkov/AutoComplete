//
//  AutoCompleteItemModel.h
//  AutoComplete
//
//  Created by Maksym Lisevych on 7/1/15.
//  Copyright (c) 2015 Oleksii Tiurenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoCompleteItemModel : NSObject
{
}

@property (nonatomic, strong) NSString *cacheId;
@property (nonatomic, strong) NSString *displayLink;
@property (nonatomic, strong) NSString *formattedUrl;
@property (nonatomic, strong) NSString *htmlFormattedUrl;
@property (nonatomic, strong) NSString *htmlSnippet;
@property (nonatomic, strong) NSString *htmlTitle;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSDictionary *pagemap;
@property (nonatomic, strong) NSString *snippet;
@property (nonatomic, strong) NSString *title;

- (instancetype)initItemFromArrayObj:(id)item;

@end
