//
//  MenuViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItems = @[@"Home",@"Mentions",@"My Profile"];
    UIViewController *viewController1 = [[TweetsViewController alloc] initWithHome];
    UIViewController *viewController2 = [[TweetsViewController alloc] initWithMentions];
    UIViewController *viewController3 = [[ProfileViewController alloc] init];
    self.viewControllers = @[viewController1, viewController2, viewController3];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menuCell"];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    NSLog(@"Created menu view");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count is %ld", self.menuItems.count);
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:@"menuCell"];
    cell.label = self.menuItems[indexPath.row];
    NSLog(@"Row is %ld", indexPath.row);
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Unselected");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewControllers[indexPath.row]];
//    self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row];
    self.hamburgerViewController.contentViewController = navController;
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
