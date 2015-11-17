//
//  LoginViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil) {
            NSLog(@"Welcome to %@", user.name);
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]];
//            [self presentViewController:navigation animated:YES completion:nil];
            MenuViewController *menuViewController = [[MenuViewController alloc] init];
            UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuViewController];
            HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] init];
            TweetsViewController *tweetsViewController = [[TweetsViewController alloc] initWithHome];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];
            hamburgerViewController.menuViewController = menuNav;
            hamburgerViewController.contentViewController = navController;
            menuViewController.hamburgerViewController = hamburgerViewController;
            [self presentViewController:hamburgerViewController animated:YES completion:nil];
        } else{
            NSLog(@"Error");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
