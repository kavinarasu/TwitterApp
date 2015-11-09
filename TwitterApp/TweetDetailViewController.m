//
//  TweetDetailViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *retweetActionImage;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userFullName;
@property (weak, nonatomic) IBOutlet UILabel *userScreenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetText.text = self.tweet.text;
    self.tweetText.preferredMaxLayoutWidth = 280;
    self.userFullName.text = self.tweet.author.name;
    self.userScreenName.text = [NSString stringWithFormat:@"\@%@", self.tweet.author.screenName];
    NSURL *url = [NSURL URLWithString:self.tweet.author.profileImageUrl];
    [self.profileImage setImageWithURL:url];
    if(self.tweet.favorited) {
        [self.favoriteImageView setImage: [UIImage imageNamed:@"like-action-on.png"]];
    }
    if(self.tweet.retweeted) {
        [self.retweetImageView setImage: [UIImage imageNamed:@"retweet-action-on.png"]];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"M/d/YY, hh:mm a";
    NSString *dateValue = [formatter stringFromDate:self.tweet.createdAt];
    self.tweetDate.text = dateValue;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld RETWEETS", (long)self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%ld FAVORITES", (long)self.tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
