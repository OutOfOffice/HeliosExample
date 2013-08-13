//
//  Author+Create.m
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "Author+Create.h"

@implementation Author (Create)

+ (Author *)authorWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Author *author = nil;
    
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Author"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (![matches count]) {
            author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:context];
            author.name = name;
            NSLog(@"create new author");
        } else {
            // Any match, pick one...
            NSLog(@"reuse existing author");
            author = [matches lastObject];
        }
    }
    
    return author;
}

@end
