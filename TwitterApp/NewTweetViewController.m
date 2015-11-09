//
//  NewTweetViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "NewTweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface NewTweetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation NewTweetViewController

- (void) onCancel {
    [self closeModal];
}

- (void) onTweet {
    NSString *status = self.tweetTextView.text;
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:status forKey:@"status"];
    [[TwitterClient sharedInstance] tweetStatus:params completion:^(Tweet *tweet, NSError *error) {
        if(error == nil) {
            NSLog(@"Successfully tweeted %@", tweet.text);
            [self closeModal];
        } else {
            NSLog(@"Tweet failed");
        }
    }];
}

- (void) closeModal {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLabel.text = self.user.name;
    self.userScreenNameLabel.text = self.user.screenName;
    NSURL *url = [NSURL URLWithString:self.user.profileImageUrl];
    [self.userProfileImageView setImageWithURL:url];
    [self.tweetTextView becomeFirstResponder];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
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
