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

+ (void)saveSearchColumn : (NSString *) column
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:column  forKey:@"SearchColumn"];

        [standardUserDefaults synchronize];
    }
    
}

+ (void)saveLoginInfo : (NSString *) unapplied : (NSString *) preAuth : (NSString *) ARSearch : (NSString *) isValid : (NSString *) error
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:unapplied  forKey:@"CreateUnapplied"];
        [standardUserDefaults setObject:preAuth  forKey:@"PreAuthorize"];
        [standardUserDefaults setObject:ARSearch  forKey:@"ARSearch"];
        [standardUserDefaults setObject:isValid  forKey:@"isValie"];
        [standardUserDefaults setObject:error  forKey:@"Error"];
        
        [standardUserDefaults synchronize];
    }
}

@end
