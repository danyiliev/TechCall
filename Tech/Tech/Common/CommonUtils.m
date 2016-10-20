//
//  CommonUtils.m
//  Tech
//
//  Created by apple on 1/11/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils
+ (id)sharedObject {
    static CommonUtils* utils = nil;
    if(utils == nil) {
        utils = [[CommonUtils alloc] init];
    }
    
    return utils;
}

+ (void)saveLastLogin : (NSString *) ipAddr : (NSString *) inviteID : (NSString *) option
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:ipAddr  forKey:@"IPAddress"];
        [standardUserDefaults setObject:inviteID  forKey:@"InviteID"];
        [standardUserDefaults setObject:option forKey:@"Option"];
        
        NSString *serverAddr;
        if ([option isEqualToString:@"SAWIN"])
            serverAddr = [NSString stringWithFormat:@"%@.com:290", ipAddr];
        else if ([option isEqualToString:@"Custom"])
            serverAddr = [NSString stringWithFormat:@"%@:290", ipAddr];
        [standardUserDefaults setObject:serverAddr forKey:@"ServerAddress"];
        
        [standardUserDefaults synchronize];
    }
}

+ (void)saveUserData:(NSString *) logintech : (NSString *) password : (NSString *) techType
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:logintech  forKey:@"LoginTech"];
        [standardUserDefaults setObject:password  forKey:@"Password"];
        [standardUserDefaults setObject:techType forKey:@"TechType"];
        
        [standardUserDefaults synchronize];
    }
}
@end
