//
//  CheckInAnnotation.h
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckInAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D  annotationCoordinate;
    NSString                *annotationTitle;
    NSString                *annotationSubtitle;
}

- (id)initWithLocation:(CLLocationCoordinate2D)location 
                 title:(NSString *)title
           andSubtitle:(NSString *)subtitle;

@property (nonatomic, copy) NSString *annotationTitle;
@property (nonatomic, copy) NSString *annotationSubtitle;

@end
