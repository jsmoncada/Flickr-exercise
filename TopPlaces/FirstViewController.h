//
//  FirstViewController.h
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSMutableArray *tableItems;
@property (strong, nonatomic) NSMutableDictionary *sections;
@end
