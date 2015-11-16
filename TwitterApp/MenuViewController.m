//
//  MenuViewController.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItems = @[@"Home",@"My Profile"];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menuCell"];
    self.menuTableView.dataSource = self;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
