//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TwitterClient.h"

NSString *const kTwitterConsumerKey = @"bKtKEH5NHFALMNJx9vwv65FfH";
NSString *const kTwitterConsumerSecret = @"G9BSD8QZ6c1XI2N9ceZnauhOdGmTAptOJ7iW7WMYnIMctV2ERC";
NSString *const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]  consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}
@end
