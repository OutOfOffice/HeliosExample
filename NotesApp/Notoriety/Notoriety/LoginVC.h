//
//  LoginVC.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"
#import "LoginVCDelegate.h"

@interface LoginVC : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) id <LoginVCDelegate> delegate;

@end
