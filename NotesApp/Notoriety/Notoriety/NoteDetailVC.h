//
//  NoteDetailVC.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDetailVCDelegate.h"
#import "Note.h"

@interface NoteDetailVC : UIViewController

@property (nonatomic, weak) id <NoteDetailVCDelegate> delegate;
@property (nonatomic, strong) Note *note;

@end
