//
//  MMGeoCoderTests.m
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>


#import "MMGeoCoder.h"

@interface MMGeoCoderTests : SenTestCase {

}

@end

@implementation MMGeoCoderTests

// Test that a valid address returns the correct coordinates
- (void)testLocationForAddressWithValidAddress {

  NSString *validAddress = @"1709 Rio Grande St. Austin, TX 78701";
  CLLocationCoordinate2D result = [MMGeoCoder locationForAddress:validAddress];
  
  STAssertTrue(result.latitude == 30.281103134155273, @"Latitude incorrect" );
  STAssertTrue(result.longitude == -97.7449951171875, @"Longitude incorrect" );
    
}

// Test that an invalid address returns zeroes
// Note: this tests may break if "My Mom's house" is ever added to Google's DB.
- (void)testLocationForAddressWithInvalidAddress {
  
  NSString *validAddress = @"My Mom's house";
  CLLocationCoordinate2D result = [MMGeoCoder locationForAddress:validAddress];
  
  STAssertTrue(result.latitude == 0, @"Latitude should be 0" );
  STAssertTrue(result.longitude == 0, @"Longitude should be 0" );
  
}

// Test that a nil address doesn't throw exception
- (void)testLocationForAddressWithNilAddress {
  
  NSString *validAddress = nil;
  STAssertNoThrow([MMGeoCoder locationForAddress:validAddress],@"No exception expected");
    
}

@end