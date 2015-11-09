//
//  Tweet.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/7/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if(self) {
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        NSNumber *favorite = dictionary[@"favorited"];
        NSNumber *retweet = dictionary[@"retweeted"];
        NSNumber *favoriteCount = dictionary[@"favorite_count"];
        NSNumber *retweetCount = dictionary[@"retweet_count"];
        self.favorited = [favorite boolValue];
        self.retweeted = [retweet boolValue];
        self.favoriteCount = [favoriteCount integerValue];
        self.retweetCount = [retweetCount integerValue];
    }
    return self;
}

+ (NSArray *) tweetsFromArray:(NSArray *) array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *tweet in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:tweet]];
    }
    return tweets;
}

@end
