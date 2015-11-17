//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

NSString *const kTwitterConsumerKey = @"bKtKEH5NHFALMNJx9vwv65FfH";
NSString *const kTwitterConsumerSecret = @"G9BSD8QZ6c1XI2N9ceZnauhOdGmTAptOJ7iW7WMYnIMctV2ERC";
NSString *const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion) (User *user, NSError *error);

@end

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

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got the request token");
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token");
        self.loginCompletion(nil, error);
    }];

}

- (void) openURL:(NSURL *) url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got the access token");
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"Failed to get home timeline");
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token");
        self.loginCompletion(nil, error);
    }];
}

- (void) homeTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@", responseObject);
        NSArray *tweets = [Tweet tweetsFromArray:responseObject];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:responseObject forKey:@"response"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) mentionsTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
    [self GET:@"1.1/statuses/mentions_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //        NSLog(@"%@", responseObject);
        NSArray *tweets = [Tweet tweetsFromArray:responseObject];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:responseObject forKey:@"response"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) tweetStatus:(NSDictionary *)params completion:(void (^)(Tweet *, NSError *))completion {
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:responseObject forKey:@"response"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        

        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) favoriteStatus:(NSNumber *)tweetId completion:(void (^)(Tweet *, NSError *))completion {
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:tweetId forKey:@"id"];
    [self POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) unfavoriteStatus:(NSNumber *)tweetId completion:(void (^)(Tweet *, NSError *))completion {
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:tweetId forKey:@"id"];
    [self POST:@"1.1/favorites/destroy.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) retweet:(NSNumber *)tweetId completion:(void (^)(Tweet *, NSError *))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) fetchUser:(NSString *)screenName completion:(void (^)(User *, NSError *))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/users/show.json"];
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:screenName forKey:@"screen_name"];
    [self GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"response is %@", responseObject);
//        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
//        completion(user, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}


@end
