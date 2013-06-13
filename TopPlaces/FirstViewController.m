//
//  FirstViewController.m
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import "FirstViewController.h"
#import "FlickrFetcher.h"
#import "PhotosAtPlaceController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize tableItems, sections;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Top Places";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableItems = [[FlickrFetcher topPlaces] mutableCopy];
    self.sections = [[NSMutableDictionary alloc] init];
    NSLog(@"%@",tableItems);
    [tableItems sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:FLICKR_PLACE_NAME ascending:YES], nil]];
    BOOL found = NO;
    NSDictionary *place = nil;
    int ctr = 0;
    for (ctr = 0;ctr < [tableItems count];ctr++)
    {
        place = [tableItems objectAtIndex:ctr];
        NSString *c = [[place objectForKey:FLICKR_PLACE_NAME] substringToIndex:1];
        
        found = NO;
        
        int ctr2 = 0;
        for (ctr2 = 0;ctr2 < [[self.sections allKeys] count];ctr2++)
        {
            NSString *str = [[self.sections allKeys] objectAtIndex:ctr2];
            if ([str isEqualToString:c])
            {
                found = YES;
                [[self.sections objectForKey:str] addObject:place];
                break;
            }
        }
        
        if (!found)
        {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
            [[self.sections objectForKey:c] addObject:place];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.sections allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    //NSDictionary *topPlace = [tableItems objectAtIndex:indexPath.row];
    NSDictionary *topPlace = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    NSString *placeName = [topPlace objectForKey:FLICKR_PLACE_NAME];
    NSArray *placeArray = [placeName componentsSeparatedByString:@", "];
    NSString *placeCityName = [placeArray objectAtIndex:0];
    NSString *placeRest = [NSString stringWithFormat:@"%@, %@",[placeArray objectAtIndex:1],[placeArray objectAtIndex:1]];
    cell.textLabel.text = placeCityName;
    cell.detailTextLabel.text = placeRest;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    //ArticleViewController *articleView = [[ArticleViewController alloc] initWithNibName:@"ArticleViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    NSDictionary *place = [tableItems objectAtIndex:indexPath.row];
    NSString *placeId = [place objectForKey:FLICKR_PLACE_ID];
    NSArray *picsAtPlace = [FlickrFetcher photosAtPlace:placeId];
    NSString *placeName = [place objectForKey:FLICKR_PLACE_NAME];
    NSString *cityName = [[placeName componentsSeparatedByString:@", "] objectAtIndex:0];
    PhotosAtPlaceController *newView = [[PhotosAtPlaceController alloc] initWithNibName:@"PhotosAtPlaceController" bundle:nil];
    
    newView.photos = picsAtPlace;
    newView.myTitle = cityName;
    
    [self.navigationController pushViewController:newView animated:YES];
    
}

@end
