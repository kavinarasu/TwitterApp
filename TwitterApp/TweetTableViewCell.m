//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "NewTweetViewController.h"
#import "ProfileViewController.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *retweetText;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserFullName;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetTime;
@property (weak, nonatomic) IBOutlet UIButton *favoriteActionButton;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *retweetActionButton;
@property (weak, nonatomic) IBOutlet UIButton *replyActionButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.favoriteActionButton setImage:[UIImage imageNamed:@"like-action-pressed.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [self.retweetActionButton setImage:[UIImage imageNamed:@"retweet-action-on-pressed.png"] forState:UIControlStateSelected | UIControlStateHighlighted];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onTappingFavorite:(id)sender {
    if(!self.tweet.favorited) {
    [[TwitterClient sharedInstance] favoriteStatus:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        if(error == nil) {
            [self setTweet:tweet];
        } else {
            NSLog(@"Error in favoriting status");
        }
    }];
    } else {
        [[TwitterClient sharedInstance] unfavoriteStatus:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
            if(error == nil) {
                [self setTweet:tweet];
            } else {
                NSLog(@"Error in favoriting status");
            }
        }];
    }
}

- (IBAction)onTappingRetweet:(id)sender {
    [self.delegate tweetTableViewCell:self retweetDidGetTappedFor:self.tweet];
}

- (IBAction)onTappingReply:(id)sender {
    [self.delegate tweetTableViewCell:self replyDidGetTappedFor:self.tweet];
}



- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.tweetText.text = self.tweet.text;
    self.tweetUserFullName.text = self.tweet.author.name;
    self.tweetUserHandle.text = [NSString stringWithFormat:@"\@%@", self.tweet.author.screenName];
    NSURL *url = [NSURL URLWithString:self.tweet.author.profileImageUrl];
    [self.profileImage setImageWithURL:url];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageTapped)];
    [self.profileImage addGestureRecognizer:tap];
    self.tweetText.preferredMaxLayoutWidth = 280;
    if(self.tweet.favorited) {
        [self.favoriteActionButton setImage: [UIImage imageNamed:@"like-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.favoriteActionButton setImage: [UIImage imageNamed:@"like-action.png"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted) {
        [self.retweetActionButton setImage: [UIImage imageNamed:@"retweet-action-on.png"] forState:UIControlStateNormal];
    }
    NSTimeInterval interval = [self.tweet.createdAt timeIntervalSinceNow];
    int roundedValue = abs((int)round(interval));
    NSLog(@"%d", roundedValue);
    NSString *dateValue;
    if(roundedValue < 60) {
        dateValue = [NSString stringWithFormat:@"%ds", roundedValue];
    } else if(roundedValue < 3600) {
        dateValue = [NSString stringWithFormat:@"%dm", roundedValue/60];
    } else if(roundedValue < 86400) {
        dateValue = [NSString stringWithFormat:@"%dh", roundedValue/1440];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/d/YY";
        dateValue = [formatter stringFromDate:self.tweet.createdAt];
    }
    self.tweetTime.text = dateValue;
    if(self.tweet.retweetedUser) {
        self.retweetText.text = [NSString stringWithFormat:@"Retweeted by %@", self.tweet.retweetedUser.name];
        self.retweetText.alpha = 1;
        self.retweetImage.alpha = 1;
    } else {
        self.retweetText.alpha = 0;
        self.retweetImage.alpha = 0;
    }
}

- (void) onImageTapped {
    [self.delegate tweetTableViewCell:self profileImageDidGetTappedFor:self.tweet];
}



@end
