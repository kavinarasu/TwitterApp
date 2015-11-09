//
//  Tweet.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/7/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic) NSNumber *tweetId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *author;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL retweeted;
@property (nonatomic) NSInteger retweetCount;
@property (nonatomic) NSInteger favoriteCount;

- (id) initWithDictionary:(NSDictionary *) dictionary;

+ (NSArray *) tweetsFromArray:(NSArray *) array;

@end
