//
//  SetupVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "SetupVC.h"
#import "CDatabase.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

@interface SetupVC ()

@end

@implementation SetupVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"Setup"];
    // Send the screen view.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createAppView] build]];
    
    // Set label tags
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil) forState:UIControlStateNormal];    [self.btnCleanDB setTitle:NSLocalizedString(@"CLEAN_DB", nil) forState:UIControlStateNormal];
    [self.btnRestoreDB setTitle:NSLocalizedString(@"RESTORE_DB", nil) forState:UIControlStateNormal];

    
    // Do any additional setup after loading the view, typically from a nib.
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.tbvSetup.backgroundColor = background;
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"Setup Screen"];
    // Send the screen view.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createAppView] build]];

}
- (IBAction)btnBackButtonSegue:(id)sender {
    [self performSegueWithIdentifier:@"backFromSetup" sender:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnCleanDB:(id)sender {
    [CDatabase dropTables];
    [CDatabase createTables];
    
    [self performSegueWithIdentifier:@"backFromSetup" sender:self.view];
}

- (IBAction)btnRestoresSampleDB:(id)sender {
    [CDatabase dropTables];
    [CDatabase createTables];
    [CDatabase fillData];
    
    
    [self performSegueWithIdentifier:@"backFromSetup" sender:self.view];
}

- (IBAction)btnBack:(id)sender {
    [self performSegueWithIdentifier:@"backFromSetup" sender:self.view];
}


@end
