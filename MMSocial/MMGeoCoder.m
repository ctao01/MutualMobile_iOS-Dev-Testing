//
//  MMGeoCoder.h
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import "MMGeoCoder.h"
#import "JSONKit.h"

@implementation MMGeoCoder 

+ (CLLocationCoordinate2D) locationForAddress:(NSString *)address {
    NSString *urlString;
    NSData *resultData;
    NSString *resultString;
    NSString *status;
    NSDictionary *resultInfo;
    CLLocationCoordinate2D result;
    
    address          = [address stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    urlString        = @"https://maps.googleapis.com/maps/api/geocode/json?";
    urlString        = [urlString stringByAppendingFormat:@"address=%@&sensor=false",address];
    
    resultData       = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];   
    resultString     = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    resultInfo       = [resultString objectFromJSONString];
    status           = [resultInfo valueForKey:@"status"];
    
    result.latitude  = 0;
    result.longitude = 0;
    
    if ([status isEqualToString:@"OK"]) {
        NSDictionary *results;
        NSDictionary *geometry;
        NSArray *location;
        NSDictionary *locationInfo;
        
        results      = [resultInfo valueForKey:@"results"];
        geometry     = [results valueForKey:@"geometry"];
        location     = [geometry valueForKey:@"location"];
                        
        locationInfo = [location objectAtIndex:0];
        
        if ([locationInfo valueForKey:@"lat"] && [locationInfo valueForKey:@"lng"]) {
            result.latitude  = [[locationInfo valueForKey:@"lat"] floatValue];
            result.longitude = [[locationInfo valueForKey:@"lng"] floatValue];
        }
    }
     
     [resultData release];
     [resultString release];
    
    return result;    
}

@end
