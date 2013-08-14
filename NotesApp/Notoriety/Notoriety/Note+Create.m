//
//  Note+Create.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "Note+Create.h"
#import "Author+Create.h"

@implementation Note (Create)

+ (Note *)noteWithText:(NSString *)text authorName:(NSString *)authorName inManagedObjectContext:(NSManagedObjectContext *)context
{
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    note.text = text;
    
    Author *author = [Author authorWithName:authorName inManagedObjectContext:context];
    note.authoredBy = author;
    note.lastEditBy = author;
    
    NSDate *now = [NSDate date];
    note.createdAt  = now;
    note.lastEditAt = now;
    
    return note;
}

- (void)editNoteText:(NSString *)text byAuthorName:(NSString *)authorName
{
    Author *author = [Author authorWithName:authorName inManagedObjectContext:self.managedObjectContext];
    self.lastEditBy = author;
    self.lastEditAt = [NSDate date];
    self.text = text;
}

@end
