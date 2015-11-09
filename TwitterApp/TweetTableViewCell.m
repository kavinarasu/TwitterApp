//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *retweetText;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserFullName;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetTime;
@property (weak, nonatomic) IBOutlet UIImageView *replyActionImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteActionImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.tweetText.text = self.tweet.text;
    self.tweetUserFullName.text = self.tweet.author.name;
    self.tweetUserHandle.text = [NSString stringWithFormat:@"\@%@", self.tweet.author.screenName];
    NSURL *url = [NSURL URLWithString:self.tweet.author.profileImageUrl];
    [self.profileImage setImageWithURL:url];
    self.tweetText.preferredMaxLayoutWidth = 280;
    if(self.tweet.favorited) {
        [self.favoriteActionImage setImage: [UIImage imageNamed:@"like-action-on.png"]];
    }
    if(self.tweet.retweeted) {
        [self.retweetImageView setImage: [UIImage imageNamed:@"retweet-action-on.png"]];
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
}

@end
