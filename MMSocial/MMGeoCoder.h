//
//  MMGeoCoder.h
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMGeoCoder : NSObject {
    
}

+ (CLLocationCoordinate2D) locationForAddress:(NSString *)address;

@end
