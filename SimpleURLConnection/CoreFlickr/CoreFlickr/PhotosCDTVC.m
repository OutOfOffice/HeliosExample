//
//  PhotosCDTVC.m
//  CoreFlickr
//
//  Created by koba on 8/12/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "PhotosCDTVC.h"
#import "Photo.h"
#import "AFNetworking.h"

@interface PhotosCDTVC ()

@end

@implementation PhotosCDTVC

#pragma mark - Properties

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    self.title = photographer.name;
    [self setupFetchedResultsController];
}

- (void)setupFetchedResultsController
{
    if (self.photographer.managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", self.photographer];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.photographer.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    cell.imageView.image = nil;
    [cell.imageView setImageWithURL:[NSURL URLWithString:photo.thumbnailURLString]
                   placeholderImage:[UIImage imageNamed:@"731-cloud-download-square"]];
    
    return cell;
    
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Display Photo"]) {
        if (![sender isKindOfClass:[UITableViewCell class]]) return;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (!indexPath) return;
        if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
            Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];

            [segue.destinationViewController performSelector:@selector(setPhoto:) withObject:photo];
            [segue.destinationViewController setTitle:photo.title];
        }
    }
}

@end
