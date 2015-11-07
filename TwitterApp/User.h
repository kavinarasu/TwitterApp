//
//  User.h
//  TwitterApp
//
//  Created by Kavin Arasu on 11/7/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

- (id) initWithDictionary:(NSDictionary *) dictionary;

@end
