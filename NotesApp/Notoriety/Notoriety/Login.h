//
//  Login.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

+ (void)setCurrentAuthorName:(NSString *)name;
+ (NSString *)currentAuthorName;

@end
