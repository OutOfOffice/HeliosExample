//
//  LoginVCDelegate.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

@class LoginVC;

@protocol LoginVCDelegate <NSObject>

- (void)loginVCDidCompleteLogin:(LoginVC *)loginVC;

@end