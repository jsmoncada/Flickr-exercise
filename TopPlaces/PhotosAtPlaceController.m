//
//  PhotosAtPlaceController.m
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import "PhotosAtPlaceController.h"
#import "ScrollViewController.h"

@interface PhotosAtPlaceController ()

@end

@implementation PhotosAtPlaceController
@synthesize photos;
@synthesize myTitle;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.title = myTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *picTitle = [[photos objectAtIndex:indexPath.row][@"title"] description];
    if([picTitle isEqualToString:@""]){
        picTitle = @"Unknown";
    }
    NSString *picDesc = [[photos objectAtIndex:indexPath.row][@"description"][@"_content"] description];
    // Configure the cell...
    
    cell.textLabel.text = picTitle;
    cell.detailTextLabel.text = picDesc;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

    NSDictionary *thePhoto = [photos objectAtIndex:indexPath.row];
    ScrollViewController *newView = [[ScrollViewController alloc] initWithNibName:@"ScrollViewController" bundle:nil];
    
    newView.photo = thePhoto;
    NSString *text = [thePhoto[@"title"] description];
    if([text isEqualToString:@""]){
        newView.myTitle = @"Unknown";
    }else{
        newView.myTitle = text;
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"RECENTVIEWS"]==nil){
        NSMutableArray *newPhotos = [NSMutableArray array];
        [newPhotos addObject:thePhoto];
        [[NSUserDefaults standardUserDefaults] setObject:newPhotos forKey:@"RECENTVIEWS"];
    }else{
        NSMutableArray *tempArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"RECENTVIEWS"] mutableCopy];
        if([tempArray indexOfObject:thePhoto] != NSNotFound){
            [tempArray removeObjectAtIndex:[tempArray indexOfObject:thePhoto]];
        }
        [tempArray addObject:thePhoto];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RECENTVIEWS"];
        [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"RECENTVIEWS"];
    
    }
    [self.navigationController pushViewController:newView animated:YES];
    
    
    /*
     PhotosAtPlaceController *newView = [[PhotosAtPlaceController alloc] initWithNibName:@"PhotosAtPlaceController" bundle:nil];
     
     newView.photos = picsAtPlace;
     newView.myTitle = cityName;
     
     [self.navigationController pushViewController:newView animated:YES];
     */
}

@end
