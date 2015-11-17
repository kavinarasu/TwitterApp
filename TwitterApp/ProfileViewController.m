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

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    [[TwitterClient sharedInstance] fetchUser:user.screenName completion:nil];
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
