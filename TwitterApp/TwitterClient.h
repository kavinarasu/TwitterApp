//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion;

- (void) openURL:(NSURL *) url;

- (void) homeTimeLineWithParams: (NSDictionary *) params completion:(void (^) (NSArray *tweets, NSError *error)) completion;

- (void) tweetStatus: (NSDictionary *) params completion:(void (^) (Tweet *tweet, NSError *error)) completion;

- (void) favoriteStatus: (NSNumber *) tweetId completion:(void (^) (Tweet *tweet, NSError *error)) completion;

- (void) unfavoriteStatus: (NSNumber *) tweetId completion:(void (^) (Tweet *tweet, NSError *error)) completion;

@end
