//
//  NoteDetailVCDelegate.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//
#import "Note.h"

@class NoteDetailVC;

@protocol NoteDetailVCDelegate <NSObject>

- (void)noteDetailVC:(NoteDetailVC *)noteDetailVC didSaveNote:(Note *)note;

@end