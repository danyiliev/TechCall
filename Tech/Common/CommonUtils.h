//
//  CommonUtils.h
//  Tech
//
//  Created by apple on 1/11/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASEURL @"http://216.15.147.97:90"

@class UIViewController;

@interface CommonUtils : NSObject

@property (strong) NSDictionary *userInfo;

+ (id)sharedObject;
+ (void)saveLastLogin : (NSString *) ipAddr : (NSString *) inviteID : (NSString *) option;
+ (void)saveUserData : (NSString *) logintech : (NSString *) password : (NSString *) techType;
+ (void)saveSearchColumn : (NSString *) column;
+ (void)saveLoginInfo : (NSString *) unapplied : (NSString *) preAuth : (NSString *) ARSearch : (NSString *) isValid : (NSString *) error;
@end