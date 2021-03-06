//
//  SecondViewController.h
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    BOOL isEditable;
    UIBarButtonItem *edit;
    UIBarButtonItem *done;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *photos;
@end
