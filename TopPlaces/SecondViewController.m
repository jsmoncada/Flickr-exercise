//
//  SecondViewController.m
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import "SecondViewController.h"
#import "ScrollViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize photos;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Recent Views";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animate
{
    [super viewDidAppear:animate];
    NSMutableArray *temp =[NSMutableArray array];
    temp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"RECENTVIEWS"] mutableCopy];
    if(temp!=nil){
        photos = [[[temp reverseObjectEnumerator] allObjects] mutableCopy];
        [self.tableView reloadData];
        
    }else{
        NSLog(@"No Recent Views");
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *temp =[NSMutableArray array];
    temp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"RECENTVIEWS"] mutableCopy];
    if(temp!=nil){
        photos = [[[temp reverseObjectEnumerator] allObjects] mutableCopy];
        [self.tableView reloadData];
        
    }else{
        NSLog(@"No Recent Views");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
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
}


@end
