//
//  MenuTableViewCell.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;


@end

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setLabel:(NSString *)label {
    NSLog(@"Setting label as %@", label);
    self.menuLabel.text = label;
}

@end
