//
//  DetailViewController.h
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface DetailViewController : UIViewController {
    UILabel         *commentLabel;
    UILabel         *dateLabel;
    UILabel         *usernameLabel;
    MKMapView       *mapView;
}

@property (nonatomic, retain) IBOutlet UILabel *usernameLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic , retain) NSDictionary * dict;

@end
