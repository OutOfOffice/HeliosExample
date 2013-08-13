//
//  Author+Create.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "Author.h"

@interface Author (Create)

+ (Author *)authorWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
