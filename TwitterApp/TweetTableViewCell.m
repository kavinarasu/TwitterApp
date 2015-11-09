//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetTableViewCell.h"

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
    self.tweetText.preferredMaxLayoutWidth = 280;
}

@end
