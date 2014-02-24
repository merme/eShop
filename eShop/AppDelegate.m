//
//  AppDelegate.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AppDelegate.h"
#import "CDatabase.h"
#import "CProductPrice.h"
#import "CRemoteDatabase.h"

static NSString *const kGaPropertyId = @"UA-43230251-3"; // Placeholder property ID.
static NSString *const kTrackingPreferenceKey = @"allowTracking";
static BOOL const kGaDryRun = NO;
static int const kGaDispatchPeriod = 30;



// Defining this object as a singleton View controllers can call its methods
static AppDelegate *sharedInstance;



@implementation AppDelegate{
    
}

@synthesize sVersion;

//Application routines:Begin
-(id) init{
    
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate!");
    }
    
    self=[super init];
    sharedInstance=self;
    
    sVersion=VERSION;
    
    
    return self;
}

// Return an instance of this class, in that way the ViewController can access to this class
+(AppDelegate*) sharedAppDelegate{
    return sharedInstance;
}

// UIApplicationDelegate interface: BEGIN
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[CDatabase printFilename];
    
    //[CRemoteDatabase dumpDDBB];
 
    //Create DB v1.0
    if(![CDatabase existsDB]){
        // Create tables
        [CDatabase createTables];
        // Ask if user wants sample data
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LOOK_OUT", nil)
                                                          message:NSLocalizedString(@"NO_SHOPS_PRODUCTS", nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"NO", nil)
                                                otherButtonTitles:NSLocalizedString(@"YES", nil), nil];
        [message show];
        
    }

    //Check version
    if([self isNewVersion]){
        // Migrate tables
    }

    
    // Do other work for customization after application launch
    // then initialize Google Analytics.
    [self initializeGoogleAnalytics];
    

    
    return YES;
}


-(NSString*) prescriptionsFilename{
    /*   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     
     //2) Create the full file path by appending the desired file name
     return [documentsDirectory stringByAppendingPathComponent:@"presc.dat"];
     */
    
    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return  [applicationDocumentsDir stringByAppendingPathComponent:@"Version.txt"];
    
    
}

-(bool) isNewVersion{
    
    NSData * myData = [NSData dataWithContentsOfFile:[self prescriptionsFilename]];
    NSError *error;
    bool bResult=false;
    
    if(myData==nil){
        NSData * myData = [NSKeyedArchiver archivedDataWithRootObject:self.sVersion];
        if (![myData writeToFile:[self prescriptionsFilename] atomically:YES]) {
                NSLog(@"There was an error saving: %@", error);
        }
        bResult=false;
    }
    else{
        sVersion = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
        bResult= [sVersion isEqualToString:VERSION];
    }
    
    return bResult;
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:NSLocalizedString(@"YES", nil)])
    {
       [CDatabase fillData];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// UIApplicationDelegate interface: END


- (void)initializeGoogleAnalytics{
    
    [[GAI sharedInstance] setDispatchInterval:kGaDispatchPeriod];
    [[GAI sharedInstance] setDryRun:kGaDryRun];
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
}

// Calls that deal with the model

@end
