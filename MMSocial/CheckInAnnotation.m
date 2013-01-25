//
//  CheckInAnnotation.m
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import "CheckInAnnotation.h"

@implementation CheckInAnnotation

@synthesize coordinate;
@synthesize annotationTitle;
@synthesize annotationSubtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)location
                 title:(NSString *)title
           andSubtitle:(NSString *)subtitle {
    
    self = [super init];
    
    if (self) {
        
        annotationCoordinate = location;
        
        [self setAnnotationTitle:title];
        [self setAnnotationSubtitle:subtitle];
        
    }
    
    return self;
}

- (NSString *)subtitle{
    return annotationSubtitle;
}

- (NSString *)title{
    return annotationTitle;
}

- (CLLocationCoordinate2D)coordinate{
    return annotationCoordinate;
    
}
- (void)dealloc {
    
    [annotationTitle release];
    [annotationSubtitle release];
    [super dealloc];
}
@end
