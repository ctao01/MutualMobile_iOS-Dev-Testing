//
//  DetailViewController.m
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "CheckInAnnotation.h"

@interface DetailViewController ()
- (void) updateMap;

@end

@implementation DetailViewController
@synthesize usernameLabel;
@synthesize commentLabel;
@synthesize dateLabel;
@synthesize mapView;
@synthesize dict = _dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) setDict:(NSDictionary *)newDict
{
    _dict = newDict;
    self.usernameLabel.text = [newDict objectForKey:@"name"];
    self.commentLabel.text = [newDict objectForKey:@"comment"];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [formatter stringFromDate:[newDict objectForKey:@"timestamp"]];
    
    [self updateMap];

}

- (void) updateMap
{
    CLLocationCoordinate2D pinCenter;
    pinCenter.latitude = [[[self.dict objectForKey:@"locationCoordinates"] objectForKey:@"latitude"] doubleValue];
    pinCenter.longitude = [[[self.dict objectForKey:@"locationCoordinates"] objectForKey:@"longitude"] doubleValue];
    
    CheckInAnnotation * annotation = [[CheckInAnnotation alloc]initWithLocation:pinCenter title:[self.dict objectForKey:@"name"] andSubtitle:[self.dict objectForKey:@"locationName"]];
    
    [self.mapView addAnnotation:annotation];
    [annotation release];
}

#pragma mark -
#pragma mark UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO: Implement this funcionality
    // HINT: The supplied class, CheckInAnnotation, may be useful

}

- (void)viewDidUnload {
    
    [self setCommentLabel:nil];
    [self setUsernameLabel:nil];
    [self setDateLabel:nil];
    [self setMapView:nil];
    
    [super viewDidUnload];
}

#pragma mark - MKMapDelegate Method

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    MKPinAnnotationView * annotationView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil]autorelease];
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    return annotationView;
    
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [commentLabel release];
    [usernameLabel release];
    [dateLabel release];
    [mapView release];
    [super dealloc];
}

@end
