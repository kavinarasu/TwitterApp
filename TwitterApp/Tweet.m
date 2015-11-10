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
        if(dictionary[@"retweeted_status"]) {
            NSDictionary *retweetDict = dictionary[@"retweeted_status"];
            [self setValuesForFieldsWithDictionary:retweetDict];
            self.retweetedUser = [[User alloc] initWithDictionary:dictionary[@"user"]];
        } else {
            [self setValuesForFieldsWithDictionary:dictionary];
        }
        BOOL favorite = [dictionary[@"favorited"] boolValue];
        BOOL retweet = [dictionary[@"retweeted"] boolValue];
        NSNumber *favoriteCount = dictionary[@"favorite_count"];
        NSNumber *retweetCount = dictionary[@"retweet_count"];
        self.favorited = favorite;
        self.retweeted = retweet;
        self.favoriteCount = [favoriteCount integerValue];
        self.retweetCount = [retweetCount integerValue];
    }
    return self;
}

- (void) setValuesForFieldsWithDictionary:(NSDictionary *) dictionary {
    self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
    self.tweetId = dictionary[@"id"];
    self.text = dictionary[@"text"];
    NSString *createdAtString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    self.createdAt = [formatter dateFromString:createdAtString];
}

+ (NSArray *) tweetsFromArray:(NSArray *) array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *tweet in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:tweet]];
    }
    return tweets;
}

@end
