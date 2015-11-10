//
//  TweetDetailViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "NewTweetViewController.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *retweetActionImage;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userFullName;
@property (weak, nonatomic) IBOutlet UILabel *userScreenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
}


- (void) updateView {
    self.tweetText.text = self.tweet.text;
    self.tweetText.preferredMaxLayoutWidth = 280;
    self.userFullName.text = self.tweet.author.name;
    self.userScreenName.text = [NSString stringWithFormat:@"\@%@", self.tweet.author.screenName];
    NSURL *url = [NSURL URLWithString:self.tweet.author.profileImageUrl];
    [self.profileImage setImageWithURL:url];
    if(self.tweet.favorited) {
        [self.favoriteButton setImage: [UIImage imageNamed:@"like-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.favoriteButton setImage: [UIImage imageNamed:@"like-action.png"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted) {
        [self.retweetButton setImage: [UIImage imageNamed:@"retweet-action-on.png"] forState:UIControlStateNormal];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"M/d/YY, hh:mm a";
    NSString *dateValue = [formatter stringFromDate:self.tweet.createdAt];
    self.tweetDate.text = dateValue;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld RETWEETS", (long)self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%ld FAVORITES", (long)self.tweet.favoriteCount];
    if(self.tweet.retweetedUser) {
        self.retweetLabel.text = [NSString stringWithFormat:@"Retweeted by %@", self.tweet.retweetedUser.name];
        self.retweetLabel.alpha = 1;
        self.retweetActionImage.alpha = 1;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFavoriteTapped:(id)sender {
    if(!self.tweet.favorited) {
        [[TwitterClient sharedInstance] favoriteStatus:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
            if(error == nil) {
                self.tweet = tweet;
                [self updateView];
            } else {
                NSLog(@"Error in favoriting status");
            }
        }];
    } else {
        [[TwitterClient sharedInstance] unfavoriteStatus:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
            if(error == nil) {
                self.tweet = tweet;
                [self updateView];
            } else {
                NSLog(@"Error in favoriting status");
            }
        }];
    }

}

- (IBAction)onRetweetTapped:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        if(error == nil) {
            self.tweet = tweet;
            [self updateView];
        } else {
            NSLog(@"Error in retweeting status");
        }
    }];
}

- (IBAction)onReplyTapped:(id)sender {
    NewTweetViewController *viewController = [[NewTweetViewController alloc] init];
    viewController.replyToId = self.tweet.tweetId;
    viewController.replyToUser = self.tweet.author;
    [viewController setUser:[User currentUser]];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:nil];
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
