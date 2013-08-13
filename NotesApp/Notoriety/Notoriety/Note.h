//
//  Note.h
//  Notoriety
//
//  Created by koba on 8/13/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * lastEditAt;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) Author *authoredBy;
@property (nonatomic, retain) Author *lastEditBy;

@end
