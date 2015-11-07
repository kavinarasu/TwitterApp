//
//  User.m
//  TwitterApp
//
//  Created by Kavin Arasu on 11/7/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if(self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
    }
    return self;
}

@end
