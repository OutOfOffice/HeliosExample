//
//  NoteDetailVC.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "NoteDetailVC.h"
#import "Login.h"
#import "Note+Create.h"

@interface NoteDetailVC ()
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@end

@implementation NoteDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.noteTextView.text = self.note.text;
}

- (IBAction)saveNote:(UIBarButtonItem *)sender
{
    [self.note editNoteText:self.noteTextView.text byAuthorName:[Login currentAuthorName]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(noteDetailVC:didSaveNote:)]) {
        [self.delegate noteDetailVC:self didSaveNote:self.note];
    }
}

@end
