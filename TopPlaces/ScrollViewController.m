//
//  ScrollViewController.m
//  TopPlaces
//
//  Created by Julia Moncada on 6/11/13.
//  Copyright (c) 2013 Julia Moncada. All rights reserved.
//

#import "ScrollViewController.h"
#import "FlickrFetcher.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController
@synthesize photo;
@synthesize imageView;
@synthesize scrollView;
@synthesize myTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [FlickrFetcher urlStringForPhotoWithFlickrInfo:self.photo format:FlickrFetcherPhotoFormatLarge];
    NSURL *url = [NSURL URLWithString:path];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.contentSize = imageView.image.size;
    [self.scrollView addSubview:imageView];
    self.title = myTitle;
    scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

@end
