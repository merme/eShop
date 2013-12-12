//
//  AppDelegate.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(AppDelegate *) sharedAppDelegate;


// Returns the internal array of timers
-(NSArray *) getShopsList;

@end
