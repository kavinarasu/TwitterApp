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

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (nonatomic, strong) NSArray *tweets;

@end

@implementation TweetsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [self.tweetsTableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailViewController *detail = [[TweetDetailViewController alloc] init];
    [detail setTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void) onLogOut {
    [User logout];
}

- (void) onCompose {
    NewTweetViewController *viewController = [[NewTweetViewController alloc] init];
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
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        for(Tweet *tweet in tweets) {
            NSLog(@"%@", tweet.text);
        }
        [self.tweetsTableView reloadData];
    }];
    // Do any additional setup after loading the view from its nib.
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
