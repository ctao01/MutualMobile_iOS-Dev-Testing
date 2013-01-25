//
//  MMSocialAppDelegate.m
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import "MMSocialAppDelegate.h"

@implementation MMSocialAppDelegate

@synthesize window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[self window] setRootViewController:[self navigationController]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc
{
    [window release];
    [navigationController release];
    [super dealloc];
}

@end
