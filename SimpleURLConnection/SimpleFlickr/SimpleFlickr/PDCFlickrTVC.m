//
//  PDCFlickrTVC.m
//  SimpleFlickr
//
//  Created by koba on 8/12/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCFlickrTVC.h"
#import "FlickrFetcher.h"

@interface PDCFlickrTVC ()
@property (nonatomic, strong) NSArray *photos; // of NSDictionary
@end

@implementation PDCFlickrTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [FlickrFetcher latestGeoreferencedPhotos];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description]; // description because could be NSNull
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_OWNER] description]; // description because could be NSNull
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Display Photo"]) {
        if (![sender isKindOfClass:[UITableViewCell class]]) return;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (!indexPath) return;
        if ([segue.destinationViewController respondsToSelector:@selector(setPhotoURL:)]) {
            NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
            [segue.destinationViewController performSelector:@selector(setPhotoURL:) withObject:url];
            [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
        }
    }
}


@end
