//
//  ScrollViewController.h
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSDictionary *photo;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *myTitle;
@property (strong, nonatomic) NSData *imageData;

@end
