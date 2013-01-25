//
//  MMSocialAppDelegate.h
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSocialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow                *window;
    UINavigationController  *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
