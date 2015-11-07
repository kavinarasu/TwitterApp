//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

@end
