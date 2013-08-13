//
//  NoteListCDTVC.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "NoteListCDTVC.h"
#import "NoteDetailVC.h"
#import "Note+Create.h"
#import "Author.h"

@interface NoteListCDTVC ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation NoteListCDTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.managedObjectContext) [self useNotesDocument];
}

- (void)useNotesDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"Notes Document"];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if (success) {
                  self.managedObjectContext = document.managedObjectContext;
              }
          }];
    } else if (document.documentState == UIDocumentStateClosed) {
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = document.managedObjectContext;
            }
        }];
    } else {
        self.managedObjectContext = document.managedObjectContext;
    }
}


#pragma mark - Properties

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastEditAt" ascending:NO]];
        request.predicate = nil;  // All notes.
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Note"];
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[[note.text description] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] objectAtIndex:0];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"last edited by: %@", note.lastEditBy.name];
    
    return cell;
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Note Detail"] || [segue.identifier isEqualToString:@"Add Note"]) {
        Note *note = nil;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = nil;
            indexPath = [self.tableView indexPathForCell:sender];
            if (!indexPath) return;
            note = [self.fetchedResultsController objectAtIndexPath:indexPath];
        } else {
            note = [Note noteWithText:@"Enter note here." authorName:@"test author" inManagedObjectContext:self.managedObjectContext];
        }
        
        NoteDetailVC *vc = (NoteDetailVC *)segue.destinationViewController;
        vc.delegate = self;
        vc.note = note;
    }
}


#pragma mark - Note Detail Delegates

- (void)noteDetailVC:(NoteDetailVC *)noteDetailVC didSaveNote:(Note *)note
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
