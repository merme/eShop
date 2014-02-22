//
//  AppDelegate.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

#define VERSION @"1.0"



@interface AppDelegate : UIResponder <UIApplicationDelegate>{

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<GAITracker> tracker;

@property NSString* sVersion;





//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(AppDelegate *) sharedAppDelegate;



@end
