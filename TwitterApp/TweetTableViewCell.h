//
//  TweetTableViewCell.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetTableViewCell;

@protocol TweetTableViewCellDelegate <NSObject>

- (void) tweetTableViewCell:(TweetTableViewCell *) tweetTableViewCell replyDidGetTappedFor:(Tweet *) tweet;

- (void) tweetTableViewCell:(TweetTableViewCell *) tweetTableViewCell retweetDidGetTappedFor:(Tweet *) tweet;

- (void) tweetTableViewCell:(TweetTableViewCell *) tweetTableViewCell profileImageDidGetTappedFor:(Tweet *) tweet;

@end

@interface TweetTableViewCell : UITableViewCell
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<TweetTableViewCellDelegate> delegate;
@end
