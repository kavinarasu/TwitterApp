//
//  NewTweetViewController.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

@class NewTweetViewController;

@protocol NewTweetViewControllerDelegate <NSObject>

- (void) newTweetViewController:(NewTweetViewController *) newTweetViewController didCreateTweet:(Tweet *) tweet;

@end

@interface NewTweetViewController : UIViewController

@property (nonatomic, strong) User *user;

@property (nonatomic, weak) id<NewTweetViewControllerDelegate> delegate;

@end
