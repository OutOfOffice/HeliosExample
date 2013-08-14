//
//  LoginVC.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "LoginVC.h"
#import "Login.h"
#import "Author+Create.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.text = [Login currentAuthorName];
}

- (void)loginComplete
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginVCDidCompleteLogin:)]) {
        [self.delegate loginVCDidCompleteLogin:self];
    }
}

- (IBAction)loginAuthor:(UIButton *)sender
{
    NSString *name = self.nameTextField.text;
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([name isEqualToString:@""]) return;
    
    if (![name isEqualToString:[Login currentAuthorName]]) {
        // Create or update current author:
        Author *author = [Author authorWithName:name inManagedObjectContext:self.managedObjectContext];
        [Login setCurrentAuthorName:author.name];
    }
    [self loginComplete];
}

@end
