//
//  TweetTableViewCell.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell
@property (nonatomic, strong) Tweet *tweet;
@end
