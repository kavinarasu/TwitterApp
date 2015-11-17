//
//  TweetsViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import "TweetDetailViewController.h"
#import "NewTweetViewController.h"
#import "JTProgressHUD.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate, TweetTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic) NSInteger *timeline;

@end

@implementation TweetsViewController

- (TweetsViewController *) initWithHome {
    self = [super init];
    if(self) {
        NSLog(@"Set to home");
        self.timeline = 0;
    }
    return self;
}

- (TweetsViewController *) initWithMentions {
    self = [super init];
    if(self) {
        NSLog(@"Set to home");
        self.timeline = 1;
    }
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
        NSLog(@"Set to home");
        self.timeline = 0;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [self.tweetsTableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    cell.delegate = self;
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailViewController *detail = [[TweetDetailViewController alloc] init];
    [detail setTweet:self.tweets[indexPath.row]];
    [detail setSourceController:self];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void) newTweetViewController:(NewTweetViewController *)newTweetViewController didCreateTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tweetsTableView reloadData];
}

- (void) tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell replyDidGetTappedFor:(Tweet *)tweet {
    NSLog(@"%@", tweet);
    NewTweetViewController *viewController = [[NewTweetViewController alloc] init];
    viewController.delegate = self;
    viewController.replyToId = tweet.tweetId;
    viewController.replyToUser = tweet.author;
    [viewController setUser:[User currentUser]];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void) tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell retweetDidGetTappedFor:(Tweet *)tweet {
    [[TwitterClient sharedInstance] retweet:tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        if(error == nil) {
            [self.tweets insertObject:tweet atIndex:0];
            [self.tweetsTableView reloadData];
        } else {
            NSLog(@"Error in retweeting status");
        }
    }];

}

- (void) onLogOut {
    [User logout];
}

- (void) onCompose {
    NewTweetViewController *viewController = [[NewTweetViewController alloc] init];
    viewController.delegate = self;
    [viewController setUser:[User currentUser]];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetsTableView.dataSource = self;
    self.tweetsTableView.delegate = self;
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweetCell"];
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    self.tweetsTableView.estimatedRowHeight = 120;
    self.title = @"Tweets";
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogOut)];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self fetchTweets];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTableView insertSubview:refresh atIndex:0];
    // Do any additional setup after loading the view from its nib.
}

- (void) onRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [refreshControl endRefreshing];
}

- (void) fetchTweets {
    [JTProgressHUD show];
    if(self.timeline == 0) {
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        for(Tweet *tweet in tweets) {
            NSLog(@"%@", tweet.text);
        }
        [self.tweetsTableView reloadData];
        [JTProgressHUD hide];
    }];
    } else {
        [[TwitterClient sharedInstance] mentionsTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for(Tweet *tweet in tweets) {
                NSLog(@"%@", tweet.text);
            }
            [self.tweetsTableView reloadData];
            [JTProgressHUD hide];
        }];
    }
    NSLog(@"Timeline is %ld", self.timeline);
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
