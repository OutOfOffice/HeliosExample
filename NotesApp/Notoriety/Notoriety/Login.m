//
//  Login.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "Login.h"

#define ICLOUD_KEY_LENGTH_MAX 64
#define CURRENT_AUTHOR_NAME_PREF_KEY @"CurrentAuthorName"

@implementation Login

+ (void)setObject:(id)object forKey:(NSString *)prefKey
{
    NSAssert([prefKey length] <= ICLOUD_KEY_LENGTH_MAX,
             @"iCloud key-value store key max length exceeded.");
    [[NSUserDefaults standardUserDefaults] setObject:object
                                              forKey:prefKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCurrentAuthorName:(NSString *)name
{
    [self setObject:name forKey:CURRENT_AUTHOR_NAME_PREF_KEY];
}

+ (NSString *)currentAuthorName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CURRENT_AUTHOR_NAME_PREF_KEY];
}

@end
