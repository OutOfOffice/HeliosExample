//
//  Note+Create.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "Note.h"

@interface Note (Create)

+ (Note *)noteWithText:(NSString *)text authorName:(NSString *)authorName inManagedObjectContext:(NSManagedObjectContext *)context;

@end
