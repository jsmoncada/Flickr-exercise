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

@synthesize myTitle;
@synthesize imageData;

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
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:path];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            //imageView = [[UIImageView alloc] init];
            imageView.image = image;
            imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
            
            scrollView.frame = self.view.bounds;
            scrollView.minimumZoomScale = scrollView.frame.size.width / imageView.frame.size.width;
            scrollView.maximumZoomScale = 6.0;
            scrollView.contentSize = imageView.image.size;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
    });
    
    self.title = myTitle;
    scrollView.delegate = self;
    [scrollView setZoomScale:scrollView.minimumZoomScale];
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:imageView];
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
