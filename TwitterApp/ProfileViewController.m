//
//  ProfileViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIView *tweetsView;
@property (weak, nonatomic) IBOutlet UIView *followingView;
@property (weak, nonatomic) IBOutlet UIView *followersView;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetsView.layer.borderWidth = 0.5;
    self.followingView.layer.borderWidth = 0.5;
    self.followersView.layer.borderWidth = 0.5;
    User *user = [User currentUser];
    [[TwitterClient sharedInstance] fetchUser:user.screenName completion:^(User * user, NSError * error) {
        NSString *urlString = [NSString stringWithFormat:@"%@/mobile", user.bannerImageUrl];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.bannerImageView setImageWithURL:url];
    }];
    self.tweetsCount.text = [user.tweetsCount stringValue];
    self.followingCount.text = [user.followingCount stringValue];
    self.followersCount.text = [user.followersCount stringValue];
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
