//
//  PhotosCDTVC.h
//  CoreFlickr
//
//  Created by koba on 8/12/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosCDTVC : CoreDataTableViewController

@property (nonatomic, strong) Photographer *photographer;

@end
